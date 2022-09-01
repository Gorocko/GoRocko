# frozen_string_literal: true

module TemplateCollection
  class EventTemplateShowSectionComponent < ViewComponent::Base
    def initialize(event_template:)
      @event_template = event_template
    end
  end
end
