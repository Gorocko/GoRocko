# frozen_string_literal: true

module Forms
  class TimeFieldComponent < ViewComponent::Base
    def initialize(form:, label_field:, attribute_field:)
      super()
      @form = form
      @label_field = label_field
      @attribute_field = attribute_field
    end
  end
end
