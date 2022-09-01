# frozen_string_literal: true

module Forms
  class TextFieldComponent < ViewComponent::Base
    def initialize(form:, label_field:, attribute_field:, data_controller: "", override_value: nil, data_value_pair: {})
      super()
      @form = form
      @label_field = label_field
      @attribute_field = attribute_field
      @data_controller = data_controller
      @override_value = override_value
      @options = {
        data: {
          controller: @data_controller
        },
        class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none
focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"
      }
      if @override_value.present?
        @options[:value] = @override_value
      end
      data_value_pair.each do |k, v|
        @options[:data][k] = v
      end
    end
  end
end
