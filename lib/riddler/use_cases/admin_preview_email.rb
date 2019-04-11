module Riddler
  module UseCases
    class AdminPreviewEmail
      attr_reader :definition, :preview_context_data, :context, :email

      def initialize definition, preview_context_data: {}
        @definition = definition
        @preview_context_data = preview_context_data
        @context = ::Riddler::Context.new preview_context_data
        @email = ::Riddler::Email.for definition, context
      end

      def process
        if email.include?
          hash = email.to_hash
          return hash unless hash.nil?

          {
            response_code: 204,
            message: "There was no email to include"
          }
        else
          {
            response_code: 204,
            include_predicate: email.include_predicate,
            message: "Excluded - the include_predicate returned false"
          }
        end
      end
    end
  end
end
