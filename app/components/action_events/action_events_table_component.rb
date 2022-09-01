# frozen_string_literal: true

module ActionEvents
  class ActionEventsTableComponent < ViewComponent::Base
    def initialize(action_events:)
      @action_events = action_events
    end
  end
end
