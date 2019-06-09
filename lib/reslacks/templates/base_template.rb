module Reslacks
  module Templates
    class BaseTemplate
      attr_reader :options

      def initialize(options = {}, template = nil)
        @options = {}
        attributes = %i[channel color icon_emoji footer mrkdwn sub_field text username]

        attributes.each do |attribute|
          @options[attribute] = send attribute
        end

        @options.merge!(attachments: attachments)

        @options.deep_merge!(options).each do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
        end

        # Override if template is provided
        override_template(template)
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
            footer_icon: footer_icon,
            mrkdwn_in: ['text'],
            text: text
          }
        ]
      end

      def channel
        ''
      end

      def color
        '#A0A0A0'
      end

      def icon_emoji
        ':100:'
      end

      def footer
        "#{Reslacks::Utils::ReslacksUtils::RESLACKS_FOOTER_TITLE} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}" 
      end

      def footer_icon
        Reslacks::Utils::ReslacksUtils::RESLACKS_ICON_SML
      end

      def message
        @options
      end

      def mrkdwn
        true
      end

      def sub_field
        app_info
      end

      def text
        ''
      end

      def username
        app_info
      end

      private

      def app_info
        "[Reslacks](https://github.com/Cian911/reslacks) - #{Reslacks::VERSION}"
      end

      def override_template(template)
        if Reslacks::Utils::ReslacksUtils.template_exists?(template)
          template = Reslacks::Utils::ReslacksUtils.include_template(template)
          @options.each do |key, _value|
            @options[key] = template.send(key.to_s) if template.respond_to?(key.to_s)
          end
        end
      end
    end
  end
end

=begin
{
    "attachments": [
        {
            "fallback": "Required plain-text summary of the attachment.",
            "color": "#36a64f",
            "pretext": "Optional text that appears above the attachment block",
            "author_name": "Bobby Tables",
            "author_link": "http://flickr.com/bobby/",
            "author_icon": "http://flickr.com/icons/bobby.jpg",
            "title": "Slack API Documentation",
            "title_link": "https://api.slack.com/",
            "text": "Optional text that appears within the attachment",
            "fields": [
                {
                    "title": "Priority",
                    "value": "High",
                    "short": false
                }
            ],
            "image_url": "http://my-website.com/path/to/image.jpg",
            "thumb_url": "http://example.com/path/to/thumb.png",
            "footer": "Slack API",
            "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png",
            "ts": 123456789
        }
    ]
}
=end
