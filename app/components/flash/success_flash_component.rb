# frozen_string_literal: true

module Flash
  class SuccessFlashComponent < ViewComponent::Base
    def initialize(title:, subtitle:)
      @title = title
      @subtitle = subtitle
    end
  end
end
