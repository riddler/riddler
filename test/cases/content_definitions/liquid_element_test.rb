require "test_helper"

class LiquidElementTest < ::Minitest::Test
  attr_reader :definition

  def setup
    @definition = {"id"=>"el_text", "name"=>"text", "content_type"=>"element", "type"=>"text", "text"=>"Hello {{ params.name | default: 'USER' | downcase | split: ' ' | first | capitalize | append: '!'}}"}
  end

  def test_with_no_context
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text", "name"=>"text", "text"=>"Hello User!"}
    context = nil

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

  def test_with_full_name_param
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text", "name"=>"text", "text"=>"Hello John!"}
    context = {"params"=>{"name"=>"JOHN SMITH"}}

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

end
