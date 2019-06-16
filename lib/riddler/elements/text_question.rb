module Riddler
  module Elements
    class TextQuestion < ::Riddler::Element
      def self.type
        "TextQuestion"
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
