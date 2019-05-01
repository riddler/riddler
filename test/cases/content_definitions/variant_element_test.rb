require "test_helper"

class VariantElementTest < ::Minitest::Test
  attr_reader :definition

  def setup
    @definition = {"id"=>"el_variant", "name"=>"text", "content_type"=>"element", "type"=>"variant", "elements"=>[{"id"=>"el_text_awesome", "name"=>"text", "content_type"=>"element", "type"=>"text", "text"=>"AWESOME!", "include_predicate"=>"params.score = 10", "include_predicate_instructions"=>[["load", "params.score"], ["to_int"], ["lit", 10], ["compare", "EQ"]]}, {"id"=>"el_text_ok", "name"=>"text", "content_type"=>"element", "type"=>"text", "text"=>"OK", "include_predicate"=>"params.score > 5", "include_predicate_instructions"=>[["load", "params.score"], ["to_int"], ["lit", 5], ["compare", "GT"]]}, {"id"=>"el_text_needs_help", "name"=>"text", "content_type"=>"element", "type"=>"text", "text"=>"How can we help?"}]}
  end

  def test_with_no_context
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text_needs_help", "name"=>"text", "text"=>"How can we help?"}
    context = nil

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

  def test_with_ok_score
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text_ok", "name"=>"text", "text"=>"OK"}
    context = {"params"=>{"score"=>6}}

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

  def test_with_awesome_score
    expected_result = {"content_type"=>"element", "type"=>"text", "id"=>"el_text_awesome", "name"=>"text", "text"=>"AWESOME!"}
    context = {"params"=>{"score"=>10}}

    result = ::Riddler.render definition, context
    result&.transform_keys! { |k| k.to_s }

    assert_equal_hash expected_result, result
  end

end
