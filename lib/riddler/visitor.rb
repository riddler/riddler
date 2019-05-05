module Riddler
  class Visitor
    DISPATCH_CACHE = Hash.new { |hash, (content_type, type)|
      hash[[content_type, type]] = :"visit_#{type.upcase}_#{content_type.upcase}"
    }

    def accept node
      visit node
    end

    private

    def visit node
      send DISPATCH_CACHE[[node.content_type, node.type]], node
    end

    def visit_CONTENT_STEP node
      node
    end

    def visit_VARIANT_STEP node
      node.steps.each { |child| visit child }
    end
  end
end

require_relative "visitors/each"
