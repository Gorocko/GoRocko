# frozen_string_literal: true

class EventActionCellTextInputComponent < ViewComponent::Base
  def initialize(event_record_form:)
    @event_record_form = event_record_form
    @event_record = @event_record_form.object
    generate_input_name
    generate_input_id
    generate_input_value
    generate_photo_upload_name
  end

  def generate_input_name
    @input_name = "action_event[action_event_records][id][#{@event_record.id}][content]"
  end

  def generate_photo_upload_name
    @photo_upload_name = "action_event[action_event_records][id][#{@event_record.id}][photos][]"
  end

  def generate_input_id
    @input_id = "schedule_event_records_#{@event_record.id}_content"
  end

  def generate_input_value
    event_action_record = ActionEventRecord.find_by(id: @event_record.id)
    @input_value = get_input_value(event_action_record:)
  end

  def get_input_value(event_action_record:)
    event_action_record.present? && event_action_record.content.present? ? event_action_record.content : nil
  end
end
