module Segment
  class View < ApplicationRecord
    has_many :filters

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
        h[condition] = value
        h
      end
    end
  end
end
