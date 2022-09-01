# frozen_string_literal: true

module ActionEventsHelper
  def set_event_records(params:)
    event_record_ids = params.require(:action_event).require(:action_event_records).permit(id: {})[:id].keys
    event_record_ids.map { |id| ActionEventRecord.find(id) }
  end

  def get_action_event_record_params(event_record_id:)
    params.require(
      :action_event
    ).require(
      :action_event_records
    ).permit(id: {})[:id][event_record_id.to_s].permit(:content, :photos)
  end

  def action_event_records_attributes(eventable_ids:, due_date:)
    dogs(eventable_ids:).map do |dog|
      {
        status: 1,
        eventable: dog,
        due_date:
      }
    end
  end

  def dogs(eventable_ids:)
    @dogs ||= eventable_ids.compact_blank.map { |id| Dog.find(id) }
  end
end
