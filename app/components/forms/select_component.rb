# frozen_string_literal: true

module Forms
  class SelectComponent < ViewComponent::Base
    def initialize(form:, label_field:, attribute_field:, data_controller:, options:)
      @form = form
      @label_field = label_field
      @attribute_field = attribute_field
      @data_controller = data_controller
      @options = options
    end
  end
end
