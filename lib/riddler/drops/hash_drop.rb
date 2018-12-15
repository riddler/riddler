module Riddler
  module Drops

    class HashDrop < ::Liquid::Drop
      attr_reader :hash

      def initialize hash
        @hash = Hash[ hash.map{ |k,v| [k.to_s, v] } ]
      end

      def liquid_method_missing method
        @hash[method]
      end

      def method_missing method, *_args
        method = method.to_s
        return super unless hash.key? method
        liquid_method_missing method
      end
    end

  end
end
