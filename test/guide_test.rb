require "test_helper"

class GuideTest < Minitest::Test
  include ::Riddler::FixtureHelpers

  def test_content_step_updates_journey_location
    definition = load_step "content_step"
    guide = ::Riddler::Guide.new definition
    journey = guide.journey

    assert_nil journey.location

    guide.next_step

    assert_equal guide.content.id, journey.location
  end

  def test_variant_step_updates_journey_location
    definition = load_step "variant_step"
    guide = ::Riddler::Guide.new definition
    journey = guide.journey

    guide.next_step

    assert_equal "st_variant/st_default", journey.location
  end

  #def test_enter_element
  #  guide = ::Riddler::Guide.new definition

  #  #assert_publishes {id: "el_text"}, topic:
  #  #assert_message id: "st_variant" do
  #  #  guide.process
  #  #end
  #end

  #def assert_message expected, &block
  #  original_producer = ::Riddler::Messaging.producer
  #  new_producer = ::Riddler::Messaging.new_producer "memory"

  #  ::Riddler::Messaging.producer = new_producer

  #  yield

  #  last_message = new_producer.last_message

  #  assert_equal_hash expected, last_message
  #ensure
  #  ::Riddler::Messaging.producer = original_producer
  #end
end
