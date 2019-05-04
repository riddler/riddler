require "test_helper"

class GuideTest < Minitest::Test
  attr_reader :definition

  def setup
    @definition = {"id"=>"el_text", "name"=>"text", "content_type"=>"element", "type"=>"text", "text"=>"Hello {{ params.name }}!"}
  end

  def test_enter_element
    guide = ::Riddler::Guide.new definition

    assert_message id: "el_text" do
      guide.process
    end
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
