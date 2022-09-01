# frozen_string_literal: true

module Flash
  class ErrorFlashComponent < ViewComponent::Base
    def initialize(title:, subtitle:)
      @title = title
      @subtitle = subtitle
    end
  end
end
