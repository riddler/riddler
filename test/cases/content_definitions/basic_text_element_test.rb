require "test_helper"

class BasicTextElementTest < ::Minitest::Test
  attr_reader :definition

  def setup
    @definition = {"id"=>"el_text", "name"=>"text", "content_type"=>"element", "type"=>"text", "text"=>"Hello {{ params.name }}!"}
  end

  def test_with_no_context
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text", "name"=>"text", "text"=>"Hello !"}
    context = nil

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

  def test_with_name_param
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text", "name"=>"text", "text"=>"Hello World!"}
    context = {"params"=>{"name"=>"World"}}

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

end
