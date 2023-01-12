# frozen_string_literal: true

module DogsHelper
  include TimeDisplayHelper
  def action_event_records_in_order_until(until_date)
    finished_action_events = ActionEventRecord.where(eventable_id: @dog.id).where(status: 3).order(due_date: :asc)
    unfinished_action_events = ActionEventRecord.where(eventable_id: @dog.id).where.not(status: 3).where(due_date: ..until_date).flat_map do |action_event_record|
      action_event_record.all_future_events(until_date)
    end
    unfinished_action_events.sort_by(&:due_date) + finished_action_events
  end

  def handle_group_id
    group_id = dog_params[:group_id]

    unless is_digit(group_id)
      group = Group.create(name: group_id)
      dog_params[:group_id] = group.id
    end
  end

  def generate_upcoming_action_event_display(dog)
    action_event_records = dog.action_event_records
    upcoming_unfinished_event_record = action_event_records.reject(&:finished?).max_by(&:due_date)
    @due_events_24_hours = action_event_records.reject(&:finished?).select do |record|
      record.due_date < 24.hours.from_now
    end
    @upcoming_action_event = upcoming_unfinished_event_record&.action_event
    @upcoming_action_event_display = if @upcoming_action_event.nil?
                                       "No Action Items"
                                     else
                                       "Next action item: #{upcoming_unfinished_event_record.action_event.title} on
                                            #{formatted_time_display(
                                              upcoming_unfinished_event_record.action_event.due_date
                                            )}"
                                     end
  end

  def is_digit(value)
    value.to_i != 0
  end
end
