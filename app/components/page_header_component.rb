# frozen_string_literal: true

class PageHeaderComponent < ViewComponent::Base
  renders_one :avatar
  renders_one :buttons
  renders_one :search_form
  def initialize(header_name:,
                 secondary_button_title:,
                 secondary_button_link:,
                 primary_button_title:,
                 primary_button_link:,
                 subtitle: "")
    @header_name = header_name
    @secondary_button_title = secondary_button_title
    @secondary_button_link = secondary_button_link
    @primary_button_title = primary_button_title
    @primary_button_link = primary_button_link
    @subtitle = subtitle
  end
end
