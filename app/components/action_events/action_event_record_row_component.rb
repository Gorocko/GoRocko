# frozen_string_literal: true

module ActionEvents
  class ActionEventRecordRowComponent < ViewComponent::Base
    include TimeDisplayHelper
    def initialize(action_event_record:)
      @action_event_record = action_event_record
    end
  end
end
