require "cgi"

module Riddler
  module ContextBuilders
    class Cookies < ::Riddler::ContextBuilder
      COOKIE_HEADER = "cookie"

      def data_available?
        (context.headers || {})[COOKIE_HEADER]
      end

      def process
        cookie_header = context.headers[COOKIE_HEADER]
        cookies_hash = generate_hash cookie_header
        context.assign "cookies", cookies_hash
      end

      private

      def generate_hash string
        cookies = ::CGI::Cookie.parse string
        hash_array = cookies.map do |key, value|
          [key, value.first]
        end
        Hash[hash_array]
      end
    end
  end
end
