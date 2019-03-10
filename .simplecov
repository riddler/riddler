SimpleCov.start do
  coverage_dir "reports/coverage"

  load_profile "test_frameworks"

  add_filter "/config/"
  add_filter "/db/"
  add_filter "/lib/tasks/"

  add_group "App", "app"
  add_group "Libraries", "lib"

  track_files "{app,lib}/**/*.rb"
end
