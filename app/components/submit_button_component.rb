# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(button_text:)
    @button_text = button_text
  end
end
