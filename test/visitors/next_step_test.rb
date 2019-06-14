require "test_helper"

module Riddler
  module Visitors
    class NextStepTest < Minitest::Test
      include ::Riddler::FixtureHelpers

      def test_content_step_is_next_step
        skip
        definition = load_step "content_step"
        guide = ::Riddler::Guide.new definition
        next_step = guide.next_step

        assert_equal guide.content, next_step
      end

      def test_variant_step_with_no_context
        skip
        definition = load_step "variant_step"
        guide = ::Riddler::Guide.new definition
        next_step = guide.next_step

        assert_equal guide.content.steps.last, next_step
      end

      def test_variant_step_with_context_for_first_step
        skip
        definition = load_step "variant_step"
        guide = ::Riddler::Guide.new definition,
          params: {name: "foo"}

        assert_equal guide.content.steps.first, guide.next_step
      end
    end
  end
end
