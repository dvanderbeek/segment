require "segment/engine"
require "segment/configuration"
require "ransack"
require "cocoon"
require "simple_form"

module Segment
  mattr_accessor :configuration
  @@configuration = Configuration.new

  def self.configure
    yield @@configuration
  end
end
