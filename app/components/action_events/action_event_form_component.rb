# frozen_string_literal: true

module ActionEvents
  class ActionEventFormComponent < ViewComponent::Base
    def initialize(action_event:, button_disabled: false)
      @action_event, = action_event,
      @button_disabled = button_disabled
    end
  end
end
