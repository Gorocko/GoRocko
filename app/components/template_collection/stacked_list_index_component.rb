# frozen_string_literal: true

module TemplateCollection
  class StackedListIndexComponent < ViewComponent::Base
    def initialize(event_template_collections:)
      @event_template_collections = event_template_collections
    end
  end
end
