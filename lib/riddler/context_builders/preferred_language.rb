module Riddler
  module ContextBuilders
    class PreferredLanguage < ::Riddler::ContextBuilder
      LANGUAGE_REGEXP = /([a-zA-Z]{2,4})(?:-[a-zA-Z]{2})?(?:;q=(1|0?\.[0-9]{1,3}))?/
      ACCEPT_LANGAUGE_HEADER = "accept_language"

      def data_available?
        context.headers&.key? ACCEPT_LANGAUGE_HEADER
      end

      def process
        preferred_language = sorted_accept_languages.first
        context.assign "preferred_language", preferred_language
      end

      private

      def sorted_accept_languages
        language_header = context.headers[ACCEPT_LANGAUGE_HEADER]
        languages = language_header.scan(LANGUAGE_REGEXP).map do |lang, q|
          [lang, (q || '1').to_f]
        end
        languages.sort_by(&:last).reverse.map(&:first)
      end
    end
  end
end
