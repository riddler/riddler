begin
  require "bundler/audit/task"

  Bundler::Audit::Task.new
rescue LoadError
end
