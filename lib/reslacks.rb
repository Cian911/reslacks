require 'slack-notifier'

# Configuration
require 'reslacks/version'
require 'reslacks/config'
require 'reslacks/errors'

# Utilities
require 'reslacks/utils/reslacks_utils'

# Clients
require 'reslacks/clients/slack_client'

# Templates
require 'reslacks/templates/base_template'
require 'reslacks/templates/danger_template'
require 'reslacks/templates/success_template'
require 'reslacks/templates/warning_template'
require 'reslacks/templates/info_template'

# Formatters
require 'reslacks/formatters/basic'
require 'reslacks/formatters/attachments'
require 'reslacks/formatters/buttons'

module Reslacks
  class << self
    attr_accessor :config
  end

  def self.deliver(msg_format = nil, template = nil, options = {})
    Reslacks::Clients::SlackClient.new(config.slack_web_hook, options, template, msg_format).deliver
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
