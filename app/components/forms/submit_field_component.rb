# frozen_string_literal: true

module Forms
  class SubmitFieldComponent < ViewComponent::Base
    def initialize(form:, button_override_text: nil, css_config_override: nil)
      @form = form
      @button_override_text = button_override_text
      @css_config_override = css_config_override
    end
  end
end
