# frozen_string_literal: true

class PrimaryButtonWithLinkComponent < ViewComponent::Base
  def initialize(button_text:, button_link:, button_size:)
    @button_text = button_text
    @button_link = button_link
    @button_size = button_size
    generate_klass_style
  end

  def generate_klass_style
    case @button_size
    when 1
      @klass_style = "inline-flex items-center px-2.5 py-1.5 border
      border-transparent text-xs font-medium rounded shadow-sm text-white bg-indigo-600
      hover:bg-indigo-700 focus:outline-none
       focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    when 2
      @klass_style = "inline-flex items-center px-3 py-2 border
      border-transparent text-sm leading-4 font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700
       focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    when 3
      @klass_style = "inline-flex items-center
      px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white
      bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    when 4
      @klass_style = "inline-flex items-center
       px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600
       hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    when 5
      @klass_style = "inline-flex items-center px-6 py-3 border border-transparent
      text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700
      focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    end
  end
end
