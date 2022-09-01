# frozen_string_literal: true

class SectionWrapperComponent < ViewComponent::Base
  renders_one :main_body
  renders_one :section_header
end
