module Riddler
  module Elements
    class Button < ::Riddler::Element
      def self.type
        "Button"
      end

      def text
        context.render definition["text"]
      end

      def to_hash
        super.merge text: text
      end
    end
  end
end
