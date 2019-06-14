require "bundler"
Bundler.require

guard :bundler do
  require "guard/bundler"
  require "guard/bundler/verify"
  helper = Guard::Bundler::Verify.new

  files = ["Gemfile"]
  files += Dir["*.gemspec"] if files.any? { |f| helper.uses_gemspec? f }

  # Assume files are symlinked from somewhere
  files.each { |file| watch helper.real_path file }
end

guard :rubocop do
  watch(/^.+\.rb$/)
  watch(/^(Gem|Guard|Rake)file$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname m[0] }
end

guard :minitest do
  watch %r{^test/(.*)\/?(.*)_test\.rb$}
  watch(%r{^lib/riddler/(.*/)?([^/]+)\.rb$}) { |m| "test/#{m[1]}#{m[2]}_test.rb" }
  watch(%r{^test/test_helper\.rb$}) { "test" }
end
