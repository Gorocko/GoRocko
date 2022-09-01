# frozen_string_literal: true

module Forms
  class CollectionCheckBoxesFieldComponent < ViewComponent::Base
    def initialize(form:, collections:, input_name:, inputs_value:)
      @form = form
      @collections = collections
      @input_name = input_name
      @inputs_value = inputs_value
    end
  end
end
