begin
  require "guard/rake_task"
  Guard::RakeTask.new
rescue LoadError
end
