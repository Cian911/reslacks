module Reslacks
  module Clients
    class Slack
      attr_accessor :msg_hash
      attr_reader :notifier, :template, :formatter

      def initialize(token, options = {}, template = nil, formatter = nil)
        @notifier = ::Slack::Notifier.new token
        @msg_hash = options
        @template = template
        @formatter = formatter
      end

      def deliver
        @msg_hash = Reslacks::Templates::Base.new(@msg_hash, @template).message
        @notifier.ping @msg_hash
      end
    end
  end
end
