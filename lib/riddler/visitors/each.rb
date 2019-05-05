module Riddler
  module Visitors
    class Each < ::Riddler::Visitor
      attr_reader :block

      def initialize block
        @block = block
      end

      private

      def visit node
        block.call node
        super
      end
    end
  end
end
