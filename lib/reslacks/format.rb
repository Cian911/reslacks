module Reslacks
  class Format
    DEFAULT_FORMAT = :basic

    attr_accessor :format, :template, :options

    def initialize(msg_format = nil, template = nil, options = {})
      @format = msg_format
      @options = options

      define_format

      @options = @format.message if @format.is_a? Object

      if define_template(template)
        @options.each do |key, value|
          # If key is not set, use template
          @options[key] = @template.send(key.to_s) if @template.respond_to?(key.to_s)
        end

        options.each do |key, value|
          # Otherwise override with users options
          @options[key] = options[key] unless @options[key] == options[key]
        end
      end
    end

    def formatted_message
      @options
    end

    private

    def define_format
      # If the passed option doesnt exist, use the default one
      if Reslacks::Utils::ReslacksUtils.formatter_exists?(@format)
        @format = Reslacks::Utils::ReslacksUtils.include_formatter(@format, @options)
      else
        @format = Reslacks::Utils::ReslacksUtils.include_formatter(DEFAULT_FORMAT, @options)
      end
    end

    def define_template(template)
      if Reslacks::Utils::ReslacksUtils.template_exists?(template)
        @template = Reslacks::Utils::ReslacksUtils.include_template(template)
        return true
      end

      false
    end
  end
end
