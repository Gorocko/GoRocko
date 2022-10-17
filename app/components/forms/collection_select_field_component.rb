# frozen_string_literal: true

module Forms
  class CollectionSelectFieldComponent < ViewComponent::Base
    def initialize(label_field:, attribute_field:, form:, collections:, value_method:, text_method:)
      @label_field = label_field
      @attribute_field = attribute_field
      @form = form
      @collections = collections,
                     @value_method = value_method,
                     @text_method = text_method
    end
  end
end
