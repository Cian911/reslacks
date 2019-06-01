module Reslacks
  module Clients
    class SlackClient
      attr_accessor :msg_hash
      attr_reader :notifier

      def initialize(token, options = {})
        @notifier = Slack::Notifier.new token
        @msg_hash = options
      end

      def deliver
        @msg_hash = Reslacks::Templates::BaseTemplate.new(@msg_hash).message
        @notifier.ping @msg_hash
      end
    end
  end
end
