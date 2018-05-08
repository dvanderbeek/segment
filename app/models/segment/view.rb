module Segment
  class View < ApplicationRecord
    COMBINATORS = %w[and or].freeze

    has_many :filters, inverse_of: :view

    validates :combinator, inclusion: { in: COMBINATORS }

    accepts_nested_attributes_for :filters, allow_destroy: true

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
        end

        h[condition] = value unless value == "current_user_id"
        h
      end
    end
  end
end
