# frozen_string_literal: true

module ActionEvents
  class ActionEventRecordRowComponent < ViewComponent::Base
    include TimeDisplayHelper
    def initialize(action_event_record:)
      @action_event_record = action_event_record
      @actionable_event = !action_event_record.new_record? && !action_event_record.action_event.finished?
    end
  end
end
