module Reslacks
  module Templates
    class BaseTemplate
      attr_reader :template

      def initialize(template = {})
        @template = template
      end

      def attachments
        [
          {
            color: color,
            fields: [{
              short: false,
              value: "<>"
            }],
            footer: footer,
            mrkdwn_in: ['text'],
            text: text
          }
        ]
      end

      def channel
        template[:channel] ? template[:channel] : ""
      end

      def color
        template[:color] ? template[:color] : "info"
      end

      def emoji
        template[:icon_emoji] ? template[:icon_emoji] : ":100:"
      end

      def footer
        template[:footer] ? template[:footer] : "#{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}"
      end

      def message
        {
          attachments: attachments,
          channel: channel,
          mrkdwn: mrkdwn,
          username: username
        }
      end

      def mrkdwn
        template[:mrkdwn] ? template[:mrkdwn] : true
      end

      def text
        template[:text] ? template[:text] : ""
      end

      def username
        template[:username] ? template[:username] : "Reslacks - #{Reslacks::VERSION}"
      end
    end
  end
end
