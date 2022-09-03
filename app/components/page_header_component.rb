# frozen_string_literal: true

class PageHeaderComponent < ViewComponent::Base
  def initialize(header_name:,
                 secondary_button_title:,
                 secondary_button_link:,
                 primary_button_title:,
                 primary_button_link:)
    @header_name = header_name
    @secondary_button_title = secondary_button_title
    @secondary_button_link = secondary_button_link
    @primary_button_title = primary_button_title
    @primary_button_link = primary_button_link
  end
end
