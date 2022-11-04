# frozen_string_literal: true

module GroupsView
  class StackedDogListGroupComponent < ViewComponent::Base
    def initialize(group:, dogs:)
      @group = group
      @dogs = dogs
    end
  end
end
