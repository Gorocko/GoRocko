# frozen_string_literal: true

module GroupsView
  class StackedDogListGroupComponent < ViewComponent::Base
    def initialize(group:)
      @group = group
    end
  end
end
