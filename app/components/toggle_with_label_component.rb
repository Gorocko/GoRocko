# frozen_string_literal: true

class ToggleWithLabelComponent < ViewComponent::Base
  def initialize(title:, subtitle:, form:, enabled:, recurring_schedule:)
    @title = title
    @subtitle = subtitle
    @form = form
    @recurring_schedule = recurring_schedule
    @button_class = "relative inline-flex flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 "
    @span_class = "pointer-events-none inline-block h-5 w-5 rounded-full bg-white shadow transform ring-0 transition ease-in-out duration-200 "
    @enabled = enabled
    if enabled
      @button_class += "bg-indigo-600"
      @span_class += " translate-x-5"
      @occurrence_class = ""
    else
      @button_class += "bg-gray-200"
      @span_class += " translate-x-0"
      @occurrence_class = "hidden"
    end
  end
end
