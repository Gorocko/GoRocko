# frozen_string_literal: true

module ActionEvents
  class ActionEventFormComponent < ViewComponent::Base
    include ActionText::TagHelper
    def initialize(action_event:, main_app:, button_disabled: false)
      @action_event, = action_event,
      @button_disabled = button_disabled
      @main_app = main_app
    end

    attr_reader :main_app
  end
end
