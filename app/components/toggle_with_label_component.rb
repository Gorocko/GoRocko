# frozen_string_literal: true

class ToggleWithLabelComponent < ViewComponent::Base
  def initialize(title:, subtitle:)
    @title = title
    @subtitle = subtitle
  end

end
