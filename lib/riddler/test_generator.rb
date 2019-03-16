require "yaml"

module ::Riddler
  class TestGenerator
    include ERB::Util
    attr_reader :project_root, :input_filename, :test_case

    def initialize project_root, input_filename
      @project_root = project_root
      @input_filename = input_filename
      @test_case = YAML.safe_load File.read input_filename
    end

    def test_case_name
      test_case["name"]
    end

    def class_name
      classify test_case_name
    end

    def definition
      test_case["definition"]
    end

    def tests
      test_case["tests"]
    end

    def generate
      folder = input_filename.dirname.basename.to_s
      output_filename = project_root.join *%W[ test cases #{folder} #{test_case_name}_test.rb ]
      puts "Generating #{output_filename.relative_path_from(project_root)}"
      output_filename.dirname.mkdir unless output_filename.dirname.exist?
      File.write output_filename, render
    end

    private

    def render
      ERB.new(test_class_template).result(binding)
    end

    def classify string
      string.split('_').collect!{ |w| w.capitalize }.join
    end

    def test_class_template
      <<~TEMPLATE
        require "test_helper"

        class <%= class_name %>Test < ::Minitest::Test
          attr_reader :definition

          def setup
            @definition = <%= definition %>
          end
        <% tests.each do |test| %>
          def test_<%= test["name"] %>
            expected_result = <%= test["result"] %>
            context = <% if test["context"].nil? %>nil<% else %><%= test["context"] %><% end %>

            result = ::Riddler.render definition, context
            result&.transform_keys! { |k| k.to_s }

            assert_equal_hash expected_result, result
          end
        <% end %>
        end
      TEMPLATE
    end
  end
end
