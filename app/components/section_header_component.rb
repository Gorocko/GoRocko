# frozen_string_literal: true

class SectionHeaderComponent < ViewComponent::Base
  def initialize(title:, subtitle: "")
    @title = title
    @subtitle = subtitle
  end
end
