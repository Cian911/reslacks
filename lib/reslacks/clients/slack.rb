module Reslacks
  module Clients
    class Slack
      attr_reader :notifier, :msg

      def initialize(token, message)
        @notifier = ::Slack::Notifier.new token
        @msg = message
      end

      def deliver
        @notifier.ping @msg
      end
    end
  end
end
