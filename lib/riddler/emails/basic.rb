require "inky"
require "premailer"

module Riddler
  module Emails
    class Basic < ::Riddler::Email
      def self.type
        "basic"
      end

      def self.generate_html template
        Inky::Core.new.release_the_kraken template
      end

      def self.inline_css html
        premailer = Premailer.new html, with_html_string: true
        premailer.to_inline_css
      end

      def self.foundation_css
        return @foundation_css if @foundation_css

        css_filename = ::Riddler.config.assets_path.join "stylesheets", "foundation-emails.css"
        @foundation_css = File.read css_filename
      end

      def subject
        context.render definition["subject"]
      end

      def body
        rendered = context.render definition["body"]
        generate_body rendered
      end

      def to_hash
        super.merge subject: subject,
          body: body
      end

      private

      def generate_body input
        body_html = self.class.generate_html input
        html = <<~HTML
          <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
            <head>
              <style>#{full_css}</style>
              <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
              <meta name="viewport" content="width=device-width">
            </head>
            <body>#{body_html}</body>
          </html>
        HTML

        self.class.inline_css html
      end

      def full_css
        [self.class.foundation_css, definition["css"]].join "\n"
      end
    end
  end
end
