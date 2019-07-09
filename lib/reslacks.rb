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
require 'reslacks/format'
require 'reslacks/formatters/basic'
require 'reslacks/formatters/attachments'
require 'reslacks/formatters/buttons'

module Reslacks
  class << self
    attr_accessor :config
  end

  def self.deliver(msg_format = nil, template = nil, options = {})
    validate_params(msg_format, template, options)
    message = formatter(msg_format, template, options)
    Reslacks::Clients::Slack.new(config.slack_web_hook, message).deliver
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

  private

  def self.formatter(msg_format, template, options)
    Reslacks::Format.new(msg_format, template, options).formatted_message
  end

  def self.validate_params(msg_format, template, options)
    raise Reslacks::FormatError, 'Invalid message_format type passed to as arg.' unless msg_format.is_a?(Symbol) || msg_format.nil?
    raise Reslacks::FormatError, 'Invalid template type passed to as arg.' unless template.is_a?(Symbol) || template.nil?
    raise Reslacks::FormatError, 'Invalid options passed as arg. Must be type of Hash.' unless options.is_a?(Hash) || options.nil?
  end
end
