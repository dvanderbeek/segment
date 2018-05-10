module Segment
  class View < ApplicationRecord
    COMBINATORS = %w[and or].freeze

    has_many :filters, inverse_of: :view

    validates :combinator, inclusion: { in: COMBINATORS }

    accepts_nested_attributes_for :filters, allow_destroy: true

    after_save :ensure_one_default_view

    def self.for_model(model, view_id)
      if view_id == "all"
        nil
      elsif view_id.nil?
        Segment::View.includes(:filters).find_by(default: true, model: model)
      else
        Segment::View.includes(:filters).find_by(id: view_id.to_i, model: model)
      end
    end

    def as(user)
      @user = user
      return self
    end

    def title
      super || "#{type.demodulize} #{id}"
    end

    def ransack
      @ransack ||= model_klass.ransack(query_with_combinator)
    end

    def model_klass
      @model_klass ||= model.safe_constantize
    end

    def query_with_combinator
      @query_with_combinator ||= query.merge(m: combinator)
    end

    def query
      @query ||= filters.pluck(:condition, :value).inject({}) do |h, filter|
        condition, value = filter[0], filter[1]

        if value == "current_user_id" && @user
          value = @user.id
        elsif condition.ends_with?("_in", "_any", "_all")
          value = value.split(", ")
        elsif matches = /\A(\d*).(day|days|month|months|year|years).ago\z/.match(value)
          value = matches[1].to_i.send(matches[2]).ago.to_date
        end

        h[condition] = value unless value == "current_user_id"
        h
      end
    end

    private

    def ensure_one_default_view
      if default?
        self.class.where(model: model).where.not(id: id).update_all(default: false)
      end
    end
  end
end
