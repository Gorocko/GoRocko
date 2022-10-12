# frozen_string_literal: true

class TakeActionPageComponent < ViewComponent::Base
  include ActionText::TagHelper
  def initialize(action_event:, in_progress_button_text:, finish_task_button_text:, main_app:)
    @action_event = action_event
    @in_progress_button_text = in_progress_button_text
    @finish_task_button_text = finish_task_button_text
    @main_app = main_app
    generate_header_fields
  end

  attr_reader :main_app

  def generate_header_fields
    @header_fields ||= %w[Dog Notes]
  end
end
