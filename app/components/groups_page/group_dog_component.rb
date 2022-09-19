# frozen_string_literal: true

module GroupsPage
  class GroupDogComponent < ViewComponent::Base
    include TimeDisplayHelper

    def initialize(dog:)
      @dog = dog
      generate_upcoming_action_event_display
    end

    def generate_upcoming_action_event_display
      action_event_records = @dog.action_event_records
      upcoming_unfinished_event_record = action_event_records.reject(&:finished?).max_by(&:due_date)
      @due_events_24_hours = action_event_records.reject(&:finished?).select do |record|
        record.due_date < 24.hours.from_now
      end
      @upcoming_action_event = upcoming_unfinished_event_record&.action_event
      if @upcoming_action_event.nil?
        @upcoming_action_event_display = "No Action Items"
      else
        @upcoming_action_event_display = "Next action item: #{upcoming_unfinished_event_record.action_event.title} on
                                            #{formatted_time_display(
                                              upcoming_unfinished_event_record.action_event.due_date
                                            )}"
      end
    end
  end
end
