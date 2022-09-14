# frozen_string_literal: true

module GroupsPage
  class GroupDogComponent < ViewComponent::Base
    include TimeDisplayHelper

    def initialize(dog:)
      @dog = dog
      generate_upcoming_action_event_display
    end

    def generate_upcoming_action_event_display
      upcoming_unfinished_event_record = @dog.action_event_records.reject(&:finished?).max_by(&:due_date)
      @upcoming_action_event = upcoming_unfinished_event_record&.action_event
      if @upcoming_action_event.nil?
        @upcoming_action_event_display = "No Action Needed"
      else
        @upcoming_action_event_display = "#{upcoming_unfinished_event_record.action_event.title} on
                                            #{formatted_time_display(upcoming_unfinished_event_record.due_date)}"
      end
    end
  end
end
