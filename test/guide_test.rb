require "test_helper"

class GuideTest < Minitest::Test
  attr_reader :definition

  def setup
    @definition = YAML.safe_load <<~DEF#, symbolize_names: true
      id: st_variant
      name: variant
      content_type: step
      type: variant
      steps:
      - id: st_basic
        name: basic
        content_type: step
        type: content
        elements:
        - id: el_text
          name: text
          content_type: element
          type: text
          text: "Hello {{ params.name }}!"
    DEF
  end

  def test_enter_element
    guide = ::Riddler::Guide.new definition

    #assert_publishes {id: "el_text"}, topic:
    #assert_message id: "st_variant" do
    #  guide.process
    #end
  end

  def assert_message expected, &block
    original_producer = ::Riddler::Messaging.producer
    new_producer = ::Riddler::Messaging.new_producer "memory"

    ::Riddler::Messaging.producer = new_producer

    yield

    last_message = new_producer.last_message

    assert_equal_hash expected, last_message
  ensure
    ::Riddler::Messaging.producer = original_producer
  end
end
