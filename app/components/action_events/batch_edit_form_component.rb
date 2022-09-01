# frozen_string_literal: true

module ActionEvents
  class BatchEditFormComponent < ViewComponent::Base
    def initialize(action_events:)
      @action_events = action_events
    end
  end
end
