require "test_helper"

module Riddler
  module Visitors
    class TestDot < Minitest::Test
      def test_basic_step
        path = File.expand_path "../fixtures/steps/content_step.yml", __dir__
        definition = YAML.load File.read path
        assert_dot definition, "[label=\"content\"]"
      end

      #def test_variable_equals_string
      #  assert_dot "foo = 'foo'", "[label=\"=\"]"
      #end

      #def test_variable_greater_than_integer
      #  assert_dot "foo > 2", "[label=\">\"]"
      #end

      #def test_variable_greater_than_string
      #  assert_dot "foo > 'foo'", "[label=\">\"]"
      #end

      #def test_variable_less_than_integer
      #  assert_dot "foo < 2", "[label=\"<\"]"
      #end

      #def test_variable_less_than_string
      #  assert_dot "foo < 'foo'", "[label=\"<\"]"
      #end

      #def test_variable_between_integers
      #  assert_dot "foo between 1 and 2", "[label=\"between\"]"
      #end

      #def test_variable_and_variable
      #  assert_dot "foo and bar", "[label=\"and\"]"
      #end

      #def test_variable_or_variable
      #  assert_dot "foo or bar", "[label=\"or\"]"
      #end

      #def test_variable_greater_than_duration_ago
      #  assert_dot "foo > 3d ago", "[label=\"ago\"]"
      #end

      #def test_variable_greater_than_duration_from_now
      #  assert_dot "foo > 3d from now", "[label=\"from now\"]"
      #end

      #def test_variable_ends_with_string
      #  assert_dot "foo ends with 'bar'", "[label=\"ends with\"]"
      #end

      #def test_variable_starts_with_string
      #  assert_dot "foo starts with 'bar'", "[label=\"starts with\"]"
      #end

      def assert_dot definition, expected_source
        guide = ::Riddler::Guide.new definition
        content = guide.content
        dot_source = content.to_dot
        assert_includes dot_source, expected_source
      end
    end
  end
end
