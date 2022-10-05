# frozen_string_literal: true

module ActionEvents
  class ActionEventRowComponent < ViewComponent::Base
    include TimeDisplayHelper
    def initialize(action_event:)
      @action_event = action_event
      @actionable_event = !action_event.new_record?
    end
  end
end
