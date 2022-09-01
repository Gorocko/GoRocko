# frozen_string_literal: true

module Forms
  class TextareaFieldComponent < ViewComponent::Base
    def initialize(label_field:, attribute_field:, form:)
      @label_field = label_field
      @attribute_field = attribute_field
      @form = form
    end
  end
end
