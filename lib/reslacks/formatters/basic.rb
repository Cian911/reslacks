module Reslacks
  module Formatters
    class Basic
      def text
        "This is some sample text."
      end

      def icon_emoji
        ":100:"
      end

      def username
        Reslacks::Utils::ReslacksUtils::RESLACKS_FOOTER_TITLE
      end
    end
  end
end
