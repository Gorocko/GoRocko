# frozen_string_literal: true

module ActionEvents
  class StackedListItemComponent < ViewComponent::Base
    include TimeDisplayHelper
    include ApplicationHelper
    include ActionEventsHelper
    def initialize(action_event:)
      @action_event = action_event
    end
  end
end
