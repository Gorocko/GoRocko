# frozen_string_literal: true

module ActionEvents
  class ShowViewDogMemberComponent < ViewComponent::Base
    include AvatarHelper
    include GravatarHelper
    include DogsHelper
    def initialize(dog:)
      @dog = dog
    end
  end
end
