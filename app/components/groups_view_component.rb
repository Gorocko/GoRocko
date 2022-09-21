# frozen_string_literal: true

class GroupsViewComponent < ViewComponent::Base
  def initialize(groups:)
    @groups = groups
  end
end
