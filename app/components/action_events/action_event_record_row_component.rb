# frozen_string_literal: true

module ActionEvents
  class ActionEventRecordRowComponent < ViewComponent::Base
    def initialize(action_event_record:)
      @action_event_record = action_event_record
    end
  end
end
