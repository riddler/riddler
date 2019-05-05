module Riddler
  class Action
    include ::Riddler::Concerns::Logging
  end
end

require_relative "actions/http_get"
