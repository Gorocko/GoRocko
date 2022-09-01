# frozen_string_literal: true

module Flash
  class FlashMessageComponent < ViewComponent::Base
    def initialize(type:, msg:)
      @type = type
      @msg = msg
    end
  end
end
