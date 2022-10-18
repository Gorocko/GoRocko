# frozen_string_literal: true

module GroupsView
  class MobileViewComponent < ViewComponent::Base
    def initialize(groups:)
      @groups = groups
    end
  end
end
