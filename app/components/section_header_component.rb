# frozen_string_literal: true

class SectionHeaderComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
