# frozen_string_literal: true

module Forms
  class SelectComponent < ViewComponent::Base
    def initialize(form:, label_field:, attribute_field:, data_controller:, options:)
      @form = form
      @label_field = label_field
      @attribute_field = attribute_field
      @data_controller = data_controller
      @options = options
      @klass_style = "mt-1 block w-full py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"

      @klass_style += " pl-3 pr-10" if @data_controller.blank?
    end
  end
end
