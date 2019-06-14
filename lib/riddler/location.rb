module Riddler
  class Location
    def initialize _location_string = nil
      @stack = []
    end

    def push node
      @stack.push node
    end

    def pop
      @stack.pop
    end

    def to_s
      @stack.map { |node| node.id }.join "/"
    end
  end
end
