# frozen_string_literal: true

module ActionEvents
  class ActionEventRecordsTableComponent < ViewComponent::Base
    def initialize(action_event_records:)
      @action_event_records = action_event_records
    end
  end
end
