# frozen_string_literal: true

module EventTemplateCollectionsHelper
  include ActionEventsHelper

  def apply_event_template_collection(due_date:, selected_dogs:, event_template_collection:)
    due_date = Time.zone.parse(due_date)
    selected_dogs_ids = selected_dogs.compact_blank.map(&:to_i)
    action_events = []
    gap_from_last = 0
    event_template_collection.event_templates.each do |event_template|
      gap_from_last += event_template.days_delta_from_last || 0
      due_date += gap_from_last.days
      action_events.append(ActionEvent.new(title: event_template.title,
        description: event_template.description,
        due_date:,
        action_event_records_attributes: action_event_records_attributes(
          eventable_ids: selected_dogs_ids, due_date:
        )))
    end
    action_events
  end
end
