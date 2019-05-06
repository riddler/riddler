module Riddler
  module Concerns
    module Includeable
      def include? ctx = nil
        return true unless has_include_predicate?
        ctx = ctx || context
        Predicator.evaluate include_predicate, ctx.to_liquid
      end

      def include_predicate
        definition["include_predicate"]
      end

      private

      def has_include_predicate?
        definition.key? "include_predicate" and
          definition["include_predicate"].to_s.strip != ""
      end
    end
  end
end
