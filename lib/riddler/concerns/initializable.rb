module Riddler
  module Concerns
    module Initializable
      def initialize args = nil
        args ||= {}
        method_strings = methods.map &:to_s

        args.each do |attribute, value|
          if method_strings.include? "#{attribute}="
            send "#{attribute}=", value
          elsif method_strings.include? attribute.to_s
            instance_variable_set "@#{attribute}", value
          end
        end

        yield self if block_given?
      end
    end
  end
end
