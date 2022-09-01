# frozen_string_literal: true

module GroupsPage
  class GroupDogComponent < ViewComponent::Base
    def initialize(dog:)
      @dog = dog
      generate_upcoming_maintanance_date
    end

    def generate_upcoming_maintanance_date
      upcoming_unfinished_event_record = @dog.action_event_records.select do |event_record|
        !event_record.finished?
      end.max_by(&:due_date)
      @upcoming_maintanance_date = if upcoming_unfinished_event_record.nil?
        "No Maintanance Needed"
      else
        upcoming_unfinished_event_record.due_date
      end
    end
  end
end
