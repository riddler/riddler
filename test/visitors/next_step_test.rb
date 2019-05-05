require "test_helper"

module Riddler
  module Visitors
    class NextStepTest < Minitest::Test
      include ::Riddler::FixtureHelpers

      def test_content_step_is_next_step
        content = ::Riddler::Content.from_definition load_step "content_step"
        next_step = content.next_step

        assert_equal content, next_step
      end

      def test_variant_step_with_no_context
        variant_step = ::Riddler::Content.from_definition load_step "variant_step"

        default_step = variant_step.steps.last

        next_step = variant_step.next_step

        assert_equal default_step, next_step
      end

      def test_variant_step_with_context_for_first_step
        definition = load_step "variant_step"
        variant_step = ::Riddler::Content.from_definition definition,
          params: {name: "foo"}

        first_step = variant_step.steps.first

        next_step = variant_step.next_step

        assert_equal first_step, next_step
      end
    end
  end
end
