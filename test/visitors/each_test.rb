require "test_helper"

module Riddler
  module Visitors
    class EachTest < Minitest::Test
      attr_reader :definition

      def setup
        path = File.expand_path "../fixtures/steps/variant_step.yml", __dir__
        contents = File.read path
        @definition = YAML.safe_load contents
      end

      def test_count
        guide = ::Riddler::Guide.new definition
        guide.content.each{ |step| p step.id }
      end
    end
  end
end
