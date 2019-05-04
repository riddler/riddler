module Riddler
  class Guide
    attr_reader :definition

    def initialize definition
      @definition = definition
    end

    def process
      ::Riddler::Messaging.producer.publish "foo", "bar"
    end
  end
end
