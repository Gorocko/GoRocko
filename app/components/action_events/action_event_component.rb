# frozen_string_literal: true

module ActionEvents
  class ActionEventComponent < ViewComponent::Base
    def initialize(action_event:)
      @action_event = action_event
      @is_recurrent_event = is_recurrent_event
      @recurrent_rule = recurrent_rule
    end

    def is_recurrent_event
      @action_event.recurring_schedule.present?
    end

    def recurrent_rule
      recurrent_schedule = IceCube::Schedule.from_hash(@action_event.recurring_schedule)
      if is_recurrent_event
        recurrent_schedule.to_s
      else
        ''
      end
    end
  end
end
