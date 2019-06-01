require 'slack-notifier'

require "reslacks/version"
require "reslacks/config"
require "reslacks/errors"
require "reslacks/clients/slack_client"
require "reslacks/templates/base_template"

module Reslacks
  class << self
    attr_accessor :config
  end

  def self.deliver(options = {})
    Reslacks::Clients::SlackClient.new(config.slack_web_hook, options).deliver
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end
