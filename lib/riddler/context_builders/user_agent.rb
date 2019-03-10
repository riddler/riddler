require "browser/aliases"
Browser::Base.include Browser::Aliases

module Riddler
  module ContextBuilders

    class UserAgent < ::Riddler::ContextBuilder
      # Look for the user_agent header and build a drop for that
      def process
        drop = UserAgentDrop.new context.headers.user_agent
        context.assign "user_agent", drop
      end
    end

    class UserAgentDrop < ::Liquid::Drop
      attr_reader :user_agent, :browser

      def initialize user_agent
        @user_agent = user_agent
        @browser = Browser.new user_agent
      end

      def liquid_method_missing method
        browser.public_send method
      end

      def method_missing method, *_args
        return super unless browser.respond_to? method
        liquid_method_missing method
      end
    end

  end
end
