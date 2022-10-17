# frozen_string_literal: true

module GroupsView
  class StackedDogListItemComponent < ViewComponent::Base
    include AvatarHelper
    include GravatarHelper
    include DogsHelper
    include TimeDisplayHelper
    def initialize(dog:)
      @dog = dog
      generate_upcoming_action_event_display(@dog)
    end
  end
end
