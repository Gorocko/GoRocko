# frozen_string_literal: true

module TemplateCollection
  class EventTemplateFormComponent < ViewComponent::Base
    def initialize(event_template_form:)
      @event_template_form = event_template_form
    end
  end
end
