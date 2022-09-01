# frozen_string_literal: true

module Forms
  class SubmitFieldComponent < ViewComponent::Base
    def initialize(form:, button_override_text: nil)
      @form = form
      @button_override_text = button_override_text
    end
  end
end
