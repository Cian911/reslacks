module Reslacks
  class Config
    attr_accessor :slack_web_hook

    def initialize
      @slack_web_hook = nil
    end
  end
end
