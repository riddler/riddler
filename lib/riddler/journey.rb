module Riddler
  class Journey
    MODEL_KEY = "jou".freeze
    include ::Riddler::Concerns::Initializable

    attr_accessor :id, :location

    def initialize *_args
      super
      generate_id
    end

    private

    def generate_id
      return unless id.nil?
      model_key = self.class.const_get :MODEL_KEY
      ulid = ULID.generate
      self.id = [model_key, ulid].join "_"
    end
  end
end
