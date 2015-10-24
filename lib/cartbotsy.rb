require "socket"
require "cartbotsy/api"
require "cartbotsy/configuration"
require "cartbotsy/config"
require "cartbotsy/parser"
require "cartbotsy/worker"
require "pry"

module Cartbotsy
  class << self
    attr_accessor :config

    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end
  end
end

Cartbotsy::Worker.start
