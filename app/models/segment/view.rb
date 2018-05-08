module Segment
  class View < ApplicationRecord
    has_many :filters

    def data
      @data ||= ransack.result
    end

    def ransack
      @ransack ||= model_klass.ransack(query)
    end

    def model_klass
      @model_klass ||= model.safe_constantize
    end

    def query
      @query ||= filters.pluck(:condition, :value).inject({}) do |h, filter|
        h[filter[0]] = filter[1]
        h
      end
    end
  end
end
