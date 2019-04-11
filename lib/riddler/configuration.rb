module Riddler

  class Configuration
    attr_accessor :context_builders

    attr_reader :riddler_path, :assets_path

    def initialize
      @riddler_path = Pathname.new File.expand_path "../..", __dir__
      @assets_path = @riddler_path.join "assets"
      @context_builders = []
    end
  end

end
