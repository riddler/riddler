$LOAD_PATH.unshift File.expand_path "../lib", __dir__

puts "Setting up test environment"
require "bundler/setup"

# This needs to be required first to setup coverage
require "simplecov"

require "hashdiff"
require "minitest/autorun"
require "minitest/pride"
require "pry-nav"
require "riddler"

module MiniTest::Assertions
  def assert_equal_hash expected, actual, message = "Hashes are not equal: "
    diff = ::HashDiff.diff expected, actual

    assert diff.empty?, -> {
      message_lines = [message, expected.to_s, actual.to_s]
      message_lines += diff.map { |arr| arr.join " " }

      message_lines.join "\n"
    }
  end
end
