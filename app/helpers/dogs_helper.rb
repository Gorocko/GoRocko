# frozen_string_literal: true

module DogsHelper
  def action_event_records_in_order_until(until_date)
    finished_action_events = ActionEventRecord.where(eventable_id: @dog.id).where(status: 3).order(due_date: :asc)
    unfinished_action_events = ActionEventRecord.where(eventable_id: @dog.id).where.not(status: 3).where(due_date: ..until_date).flat_map do |action_event_record|
      action_event_record.all_future_events(until_date)
    end
    unfinished_action_events.sort_by(&:due_date) + finished_action_events
  end
end
