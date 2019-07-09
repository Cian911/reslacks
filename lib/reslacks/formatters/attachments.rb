module Reslacks
  module Formatters
    class Attachments
      attr_accessor :formatted_message

      def initialize(options = {})
        @options = {}
        @formatted_message = {}
        @additional_options = {}
        attributes = %i[author_name author_link author_icon title title_link fields color footer mrkdwn sub_field mrkdwn_in]

        # Create base options
        attributes.each do |attribute|
          @options[attribute] = send attribute
        end

        # Override options with user passed options
        @options.deep_merge!(options).map do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
        end

        # Check for options outside of attachment methods
        @formatted_message[:attachments] = @options
        @options.each do |key, value|
          @formatted_message[key] = value unless respond_to?(key.to_s)
        end
      end

      def author_name
        'Reslacks'
      end

      def author_link
        Reslacks::Utils::ReslacksUtils::RESLACKS_REPO_LINK
      end

      def author_icon
        Reslacks::Utils::ReslacksUtils::RESLACKS_ICON_MED
      end

      def title
        'Notification'
      end

      def title_link
        ''
      end

      def fields
        [{
          short: false,
          value: 'Priority',
          title: 'Medium'
        }]
      end

      def color
        '#A0A0A0'
      end

      def footer
        "#{Reslacks::Utils::ReslacksUtils::RESLACKS_FOOTER_TITLE} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}"
      end

      def footer_icon
        Reslacks::Utils::ReslacksUtils::RESLACKS_ICON_SML
      end

      def mrkdwn_in
        ['text']
      end

      def mrkdwn
        true
      end

      def sub_field
        app_info
      end

      def pretext
        'This is some pretext'
      end

      def message
        @formatted_message
      end

      private

      def app_info
        "[Reslacks](https://github.com/Cian911/reslacks) - #{Reslacks::VERSION}"
      end
    end
  end
end
