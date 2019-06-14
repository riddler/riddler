module Riddler
  module Visitors
    class Dot < ::Riddler::Visitor
      attr_reader :nodes, :edges

      def initialize
        @nodes = []
        @edges = []
      end

      def accept node
        super
        <<~DOT
          digraph content_tree {
            size="8,5"
            node [shape = none];
            edge [dir = none];
            #{@nodes.join "\n  "}
            #{@edges.join "\n  "}
          }
        DOT
      end

      private

      def visit_steps node
        node.steps.each do |child|
          @edges << "#{node.id} -> #{child.id};"
        end
        super
      end

      def visit_VARIANT_STEP node
        @nodes << "#{node.id} [label=\"VARIANT: #{node.name}\"];"
        super
      end

      def terminal node
        @nodes << "#{node.id} [label=\"#{node.name}\"];"
      end
    end
  end
end
