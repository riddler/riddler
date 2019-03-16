require "pathname"
require "riddler/test_generator"

namespace :testcases do
  desc "Generate testcase classes from riddler_tests"
  task :generate do
    riddler_root = Pathname.new File.expand_path "../..", __dir__
    testcases_path = riddler_root.join "../riddler_tests"

    testcases_path.glob "content_definitions/*.yml" do |file|
      generator = ::Riddler::TestGenerator.new riddler_root, file
      generator.generate
    end
  end
end
