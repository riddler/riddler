require "test_helper"

class ContentTest < Minitest::Test
  include ::Riddler::FixtureHelpers

  def test_from_element_content_definition
    definition = load_element "text_element"
    content = ::Riddler::Content.from_definition definition
    assert_kind_of ::Riddler::Element, content
  end

  def test_from_step_content_definition
    definition = load_step "content_step"
    content = ::Riddler::Content.from_definition definition
    assert_kind_of ::Riddler::Step, content
  end
end
