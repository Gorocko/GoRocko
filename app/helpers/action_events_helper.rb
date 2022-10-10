# frozen_string_literal: true

module ActionEventsHelper
  def set_event_records(params:)
    event_record_ids = params.require(:action_event).require(:action_event_records).permit(id: {})[:id].keys
    event_record_ids.map { |id| ActionEventRecord.find(id) }
  end

  def action_events_in_order_until(until_date)
    finished_action_events = ActionEvent.where(status: 3).order(due_date: :asc)
    unfinished_action_events = ActionEvent.where.not(status: 3).where(due_date: ..until_date).flat_map do |action_event|
      action_event.all_future_events(until_date)
    end
    unfinished_action_events.sort_by(&:due_date) + finished_action_events
  end

  def get_action_event_record_params(event_record_id:)
    params.require(
      :action_event
    ).require(
      :action_event_records
    ).permit(id: {})[:id][event_record_id.to_s].permit(:content, :photos)
  end

  def check_occurrence_schedule
    return unless should_check_schedule_rule

    unless valid_occurrence_schedule_rule(occurrence_schedule)
      errors.add(:base, 'not valid')
      @action_event.errors.add(:recurrent_event, 'Repeats interval is not valid')
    end
  end

  def valid_occurrence_schedule_rule(occurrence_schedule)
    return false if occurrence_schedule[:occurrence_frequency].blank?

    true
  end

  def should_check_schedule_rule
    return false if occurrence_schedule.nil? || (occurrence_schedule[:recurrent_event] != 'true')

    true
  end

  def recurring_schedule_rule(occurrence_schedule)
    return nil unless should_check_schedule_rule

    return nil unless valid_occurrence_schedule_rule(occurrence_schedule)

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
