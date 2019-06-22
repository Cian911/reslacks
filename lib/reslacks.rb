# Dependendencies
require 'slack-notifier'

# Configuration
require 'reslacks/version'
require 'reslacks/config'
require 'reslacks/errors'

# Utilities
require 'reslacks/utils/reslacks_utils'

# Clients
require 'reslacks/clients/slack'

# Templates
require 'reslacks/templates/base'
require 'reslacks/templates/danger'
require 'reslacks/templates/success'
require 'reslacks/templates/warning'
require 'reslacks/templates/info'

# Formatters
require 'reslacks/formatters/basic'
require 'reslacks/formatters/attachments'
require 'reslacks/formatters/buttons'

module Reslacks
  class << self
    attr_accessor :config
  end

  def self.deliver(msg_format = nil, template = nil, options = {})
    Reslacks::Clients::Slack.new(config.slack_web_hook, options, template, msg_format).deliver
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
