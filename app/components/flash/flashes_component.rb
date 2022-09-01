# frozen_string_literal: true

module Flash
  class FlashesComponent < ViewComponent::Base
    def initialize(flash:)
      @flash = flash
    end
  end
end
