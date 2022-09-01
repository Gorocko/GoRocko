# frozen_string_literal: true

module Forms
  class CheckBoxFieldComponent < ViewComponent::Base
    def initialize(input_name:, box_value:, label_field:, check_box_id:, checked:)
      @input_name = input_name
      @box_value = box_value
      @label_field = label_field
      @check_box_id = check_box_id
      @checked = checked
    end
  end
end
