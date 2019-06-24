module Reslacks
  module Formatters
    class Buttons
      def main_text
        "Would you like to play a game?"
      end

      def sub_text
        "Choose a game to play"
      end

      def fallback
        "You are unable to choose a game"
      end

      def callback_id
        "wopr_game"
      end

      def color
        "#3AA3E3"
      end

      def attachment_type
        "default"
      end

      def actions
        [
          {
              "name": "game",
              "text": "Chess",
              "type": "button",
              "value": "chess"
          },
          {
              "name": "game",
              "text": "Falken's Maze",
              "type": "button",
              "value": "maze"
          },
          {
              "name": "game",
              "text": "Thermonuclear War",
              "style": "danger",
              "type": "button",
              "value": "war",
              "confirm": {
                  "title": "Are you sure?",
                  "text": "Wouldn't you prefer a good game of chess?",
                  "ok_text": "Yes",
                  "dismiss_text": "No"
              }
          }
        ]
      end
    end
  end
end
