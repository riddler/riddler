require_relative "messaging/base_producer"
require_relative "messaging/memory_producer"

module Riddler
  module Messaging
    def self.producer
      @producer ||= self.new_producer "memory"
    end

    def self.producer= new_producer
      @producer = new_producer
    end

    def self.new_producer producer_type
      producer_class =
        case producer_type
        when "memory" then self.const_get "MemoryProducer"
        else
          raise "Unknown Messaging Producer type: #{producer_type}"
        end

      producer_class.new
    end
  end
end
