# frozen_string_literal: true

class ActionEventForm < YAAF::Form
  include ActionEventsHelper
  attr_accessor :title, :due_date, :description, :tag_list, :action_event_records, :occurrence_schedule

  validate :check_occurrence_schedule
  before_save :set_recurring_schedule_rule

  def initialize(attributes)
    super(attributes)
    @models = [action_event]
  end

  def set_recurring_schedule_rule
    recurring_schedule_rule = recurring_schedule_rule(occurrence_schedule)

    @action_event.recurring_schedule = if recurring_schedule_rule(occurrence_schedule).present?
                                         IceCube::Schedule.new(start_time = Time.zone.parse(due_date)) do |s|
                                           s.add_recurrence_rule(recurring_schedule_rule)
                                         end
                                       end
  end

  def action_event
    @action_event ||= ActionEvent.new(
      title:,
      description:,
      due_date: Time.zone.parse(due_date),
      status: 1,
      tag_list:,
      action_event_records_attributes: action_event_records_attributes(
        eventable_ids: action_event_records["eventable_ids"], due_date: Time.zone.parse(due_date)
      )
    )
  end

  def update_reminder(action_event_to_update:)
    action_event_to_update.title = title
    action_event_to_update.description = description
    action_event_to_update.due_date = due_date
    action_event_to_update.tag_list = tag_list

    update_action_event_selected_dogs(action_event: action_event_to_update,
                                      new_selected_eventable_ids: action_event_records["eventable_ids"])
    @action_event = action_event_to_update
    @models = [@action_event]
  end

  def update_action_event_selected_dogs(action_event:, new_selected_eventable_ids:)
    old_selected_eventable_ids = action_event.dogs.map(&:id)
    new_selected_eventable_ids = action_event_records["eventable_ids"]
    eventable_ids_to_be_keep = old_selected_eventable_ids & new_selected_eventable_ids
    eventable_ids_to_delete = old_selected_eventable_ids - eventable_ids_to_be_keep
    eventable_ids_to_add = new_selected_eventable_ids - eventable_ids_to_be_keep

    action_event_records_to_delete = action_event.action_event_records.select do |record|
      eventable_ids_to_delete.include?(record.eventable_id)
    end
    action_event_records_to_delete.each(&:destroy)
    dogs(eventable_ids: eventable_ids_to_add).each do |dog|
      ActionEventRecord.create(
        status: 1,
        eventable: dog,
        action_event_id: action_event.id,
        due_date:
      )
    end
  end
end
