# frozen_string_literal: true

module ActionEvents
  class ActionEventRowComponent < ViewComponent::Base
    include TimeDisplayHelper
    def initialize(action_event:)
      @action_event = action_event
    end
  end
end
