module Riddler
  module Steps
    class Content < ::Riddler::Step
      TYPE = "content".freeze

      def elements
        @elements ||= definition["elements"]
          .map do |element_definition|
            ::Riddler::Element.for element_definition, context
          end
          .select(&:include?)
      end

      def to_hash
        hash = super
        hash["elements"] = elements.map do |element|
          element.to_hash
        end
        hash
      end
    end
  end
end
