module Reslacks
  module Clients
    class SlackClient
      attr_accessor :msg_hash
      attr_reader :notifier, :template

      def initialize(token, options = {}, template = nil)
        @notifier = Slack::Notifier.new token
        @msg_hash = options
        @template = template
      end

      def deliver
        @msg_hash = Reslacks::Templates::BaseTemplate.new(@msg_hash, @template).message
        @notifier.ping @msg_hash
      end
    end
  end
end
