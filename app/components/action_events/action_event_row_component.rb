# frozen_string_literal: true

module ActionEvents
  class ActionEventRowComponent < ViewComponent::Base
    def initialize(action_event:)
      @action_event = action_event
    end
  end
end
