# frozen_string_literal: true

module GroupsPage
  class GroupDogComponent < ViewComponent::Base
    include TimeDisplayHelper
    include DogsHelper

    def initialize(dog:)
      @dog = dog
      generate_upcoming_action_event_display(@dog)
    end
  end
end
