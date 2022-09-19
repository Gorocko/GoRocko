# frozen_string_literal: true

class GroupViewComponent < ViewComponent::Base
  include AvatarHelper
  include ApplicationHelper
  include ActionView::Helpers::AssetTagHelper
  def initialize(group:)
    @group = group
    @dogs = group.dogs
  end
end
