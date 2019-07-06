module Reslacks
  module Templates
    class Base
      attr_reader :options, :formatted_message

      def initialize(options = {}, template = nil)
        @formatted_message = {}
        @base_options = {}
        @options = {}

        main_attributes = %i[icon_emoji text username channel]
        attachment_attributes = %i[author_name author_link author_icon title title_link fields color footer mrkdwn sub_field mrkdwn_in]
        byebug
        # Apply base options
        attachment_attributes.each do |attribute|
          @options[attribute] = send attribute
        end

        main_attributes.each do |attribute|
          @base_options[attribute] = send attribute
        end

        # Override if template is provided
        override_template(template)

        # Override options with user passed options
        @options.deep_merge!(options).map do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
        end

        @base_options.merge!(options).map do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
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

      def channel
        ''
      end

      def color
        '#A0A0A0'
      end

      def icon_emoji
        ':100:'
      end

      def fields
        [{
          short: false,
          value: 'Priority',
          title: 'Medium'
        }]
      end

      def footer
        "#{Reslacks::Utils::ReslacksUtils::RESLACKS_FOOTER_TITLE} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}"
      end

      def footer_icon
        Reslacks::Utils::ReslacksUtils::RESLACKS_ICON_SML
      end

      def message
        @formatted_message = @base_options
        @formatted_message[:attachments] = @options
        @formatted_message
      end

      def mrkdwn
        true
      end

      def mrkdwn_in
        ['text']
      end

      def sub_field
        app_info
      end

      def pretext
        'This is some pretext'
      end

      def text
        'Reslacks test integration is working. Please override this value with your desired value.'
      end

      def title
        'Notification'
      end

      def title_link
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
            @base_options[key] = template.send(key.to_s) if template.respond_to?(key.to_s) && @base_options.key?(key)
          end
        end
      end
    end
  end
end
