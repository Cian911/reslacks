module Reslacks
  module Formatters
    class Basic
      def initialize(options = {})
        @options = {}
        attributes = %i[icon_emoji text username channel color]

        # Create base options
        attributes.each do |attribute|
          @options[attribute] = send attribute
        end

        # Override options with user passed options
        @options.deep_merge!(options).map do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
        end
      end

      def color
        '#ffffff'
      end

      def channel
        '#general'
      end

      def text
        'This is some sample text.'
      end

      def icon_emoji
        ':100:'
      end

      def username
        Reslacks::Utils::ReslacksUtils::RESLACKS_FOOTER_TITLE
      end

      def message
        @options
      end
    end
  end
end
