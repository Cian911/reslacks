module Reslacks
  module Templates
    class BaseTemplate
      attr_reader :template

      def initialize(template = {})
        @template = {}
        attributes = [:channel ,:color, :icon_emoji, :footer, :mrkdwn, :sub_field, :text, :username]

        attributes.each do |attribute|
          @template[attribute] = self.send attribute
        end

        @template.merge!(template).each do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
        end
      end

      def attachments
        [
          {
            color: color,
            fields: [{
              short: false,
              value: "<#{sub_field}>"
            }],
            footer: footer,
            mrkdwn_in: ['text'],
            text: text
          }
        ]
      end

      def channel
        ""
      end

      def color
        "info"
      end

      def icon_emoji
        ":100:"
      end

      def footer
        "#{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}"
      end

      def message
        @template.merge!({ attachments: attachments })
      end

      def mrkdwn
        true
      end

      def sub_field
        app_info
      end

      def text
        ""
      end

      def username
        app_info
      end

      private

      def app_info
        "[Reslacks](https://github.com/Cian911/reslacks) - #{Reslacks::VERSION}"
      end
    end
  end
end
