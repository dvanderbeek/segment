module Segment
  class Configuration
    attr_accessor :base_controller, :routing_namespace

    def base_controller
      @base_controller ||= "::ApplicationController"
    end
  end
end