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

  def recurring_schedule_rule(occurrence_schedule)
    return nil if occurrence_schedule.nil? || (occurrence_schedule[:recurrent_event] != 'true')

    recurring_schedule_rule =
      case occurrence_schedule[:occurrence_type]
      when 'days'
        IceCube::Rule.daily(occurrence_schedule[:occurrence_frequency].to_i)
      when 'weeks'
        IceCube::Rule.weekly(occurrence_schedule[:occurrence_frequency].to_i)
      when 'months'
        IceCube::Rule.monthly(occurrence_schedule[:occurrence_frequency].to_i)
      else
        IceCube::Rule.yearly(occurrence_schedule[:occurrence_frequency].to_i)
      end
    case occurrence_schedule[:schedule_end_method]
    when 'date'
      recurring_schedule_rule = recurring_schedule_rule.until(Time.zone.parse(occurrence_schedule[:schedule_end_date]))
    when 'occurrence_times'
      recurring_schedule_rule = recurring_schedule_rule.count(occurrence_schedule[:schedule_end_counts].to_i)
    else
      # do nothing
    end
    recurring_schedule_rule
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
