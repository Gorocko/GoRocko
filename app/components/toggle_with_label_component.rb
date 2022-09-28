# frozen_string_literal: true

class ToggleWithLabelComponent < ViewComponent::Base
  def initialize(title:, subtitle:, form:)
    @title = title
    @subtitle = subtitle
    @form = form
  end
end
