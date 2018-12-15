module Riddler

  class Configuration
    attr_accessor :context_builders

    def initialize
      @context_builders = [::Riddler::ContextBuilders::UserAgent]
    end
  end

end
