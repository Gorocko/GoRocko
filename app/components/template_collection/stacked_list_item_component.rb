# frozen_string_literal: true

module TemplateCollection
  class StackedListItemComponent < ViewComponent::Base
    def initialize(event_template_collection:)
      @event_template_collection = event_template_collection
    end
  end
end
