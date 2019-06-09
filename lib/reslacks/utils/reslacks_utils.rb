module Reslacks
  module Utils
    class ReslacksUtils
      # Image details
      RESLACKS_ICON_LRG = "https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png".freeze
      RESLACKS_ICON_MED = "https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png".freeze
      RESLACKS_ICON_SML = "https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png".freeze
      # Name details
      RESLACKS_FOOTER_TITLE = "Reslacks ##{Reslacks::VERSION}".freeze

      def self.template_exists?(class_name)
        class_name = "Reslacks::Templates::#{class_name.to_s.capitalize}Template"
        klass = Module.const_get(class_name)
        return klass.is_a?(Class)
      rescue NameError
        return false
      end

      def self.include_template(template)
        template = "Reslacks::Templates::#{template.to_s.capitalize}Template".constantize
        template.new
      end
    end
  end
end
