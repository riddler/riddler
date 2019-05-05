require "test_helper"

module Riddler
  module Visitors
    class EachTest < Minitest::Test
      include ::Riddler::FixtureHelpers

      def test_called_for_content_step
        content = ::Riddler::Content.from_definition load_step "content_step"
        count = 0
        content.each{ |step| count = count + 1 }

        assert_equal 1, count, "Expected block to be called 1 time"
      end
    end
  end
end
