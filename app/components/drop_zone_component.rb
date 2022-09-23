# frozen_string_literal: true

class DropZoneComponent < ViewComponent::Base
  renders_one :list_area
  renders_one :svg_icon
  def initialize(label_title:, file_field:, accept_format:, hint_text:, form:)
    @label_title = label_title
    @file_field = file_field
    @accept_format = accept_format
    @hint_text = hint_text
    @form = form
  end
end
