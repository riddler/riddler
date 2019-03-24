require "test_helper"

class PreferredLanguageTest < Minitest::Test
  attr_reader :builder, :context

  def setup
    @context = ::Riddler::Context.new
    @builder = ::Riddler::ContextBuilders::PreferredLanguage.new context
  end

  def test_adds_preferred_language
    tests = {
      "en-US,en;q=0.9" => "en",
      "es,en-US;q=0.9,en;q=0.8" => "es"
    }

    tests.each do |accept_language, expected_language|
      headers = {"accept_language" => accept_language}
      context = ::Riddler::Context.new headers: headers
      builder = ::Riddler::ContextBuilders::PreferredLanguage.new context

      builder.process
      preferred_language = context.variable "preferred_language"

      assert_equal expected_language, preferred_language
    end
  end
end
