module Riddler
  module Emails
    class Variant < ::Riddler::Email
      def self.type
        "variant"
      end

      def emails
        @emails ||= definition["emails"].map do |hash|
          ::Riddler::Email.for hash, context
        end
      end

      def included_email
        emails.detect &:include?
      end

      def to_hash
        included_email&.to_hash
      end
    end
  end
end
