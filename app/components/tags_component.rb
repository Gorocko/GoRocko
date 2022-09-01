# frozen_string_literal: true

class TagsComponent < ViewComponent::Base
  def initialize(tags:)
    @tags = tags
  end
end
