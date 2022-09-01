# frozen_string_literal: true

class TakeActionPageComponent < ViewComponent::Base
  def initialize(action_event:, in_progress_button_text:, finish_task_button_text:)
    @action_event = action_event
    @in_progress_button_text = in_progress_button_text
    @finish_task_button_text = finish_task_button_text
    generate_header_fields
  end

  def generate_header_fields
    @header_fields ||= ["Dog", "Notes"]
  end
end
