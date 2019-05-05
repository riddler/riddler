module Riddler
  class Visitor
    DISPATCH_CACHE = Hash.new { |hash, (content_type, type)|
      hash[[content_type, type]] = :"visit_#{type.upcase}_#{content_type.upcase}"
    }

    def accept node
      visit node
    end

    private

    def terminal node
      node
    end

    def visit node
      send DISPATCH_CACHE[[node.content_type, node.type]], node
    end

    def visit_steps node
      node.steps.each { |child| visit child }
    end

    def visit_CONTENT_STEP node
      terminal node
    end

    def visit_VARIANT_STEP node
      visit_steps node
    end
  end
end

require_relative "visitors/each"
require_relative "visitors/dot"
require_relative "visitors/next_step"
