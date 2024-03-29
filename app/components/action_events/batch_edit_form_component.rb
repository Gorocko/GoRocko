# frozen_string_literal: true

module ActionEvents
  class BatchEditFormComponent < ViewComponent::Base
    def initialize(action_events:, main_app:)
      @action_events = action_events
      @main_app = main_app
    end
  end
end
