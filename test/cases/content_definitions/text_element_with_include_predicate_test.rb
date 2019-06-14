require "test_helper"

class TextElementWithIncludePredicateTest < ::Minitest::Test
  attr_reader :definition

  def setup
    @definition = {"id"=>"el_text", "name"=>"text", "content_type"=>"Element", "type"=>"Text", "text"=>"hello", "include_predicate"=>"params.name = 'foo'", "include_predicate_instructions"=>[["load", "params.name"], ["to_str"], ["lit", "foo"], ["compare", "EQ"]]}
  end

  def test_with_no_context
    expected_result = nil
    context = nil

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

  def test_with_correct_name_param
    expected_result = {"content_type"=>"Element", "type"=>"Text", "id"=>"el_text", "name"=>"text", "text"=>"hello"}
    context = {"params"=>{"name"=>"foo"}}

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

end
