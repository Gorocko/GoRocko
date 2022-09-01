# frozen_string_literal: true

class ActionEventCollectionsController < ApplicationController
  def create
    action_event_collection_params.each do |action_event_params|
      ActionEventForm.new(map_action_event_collection_params(action_event_params)).save
    end
    redirect_to(action_events_path)
  end

  def map_action_event_collection_params(action_event_params)
    {
      title: action_event_params["action_event[title]"],
      due_date: action_event_params["action_event[due_date]"],
      description: action_event_params["action_event[description]"],
      action_event_records: {
        "eventable_ids" =>
          action_event_params["action_event[action_event_records][eventable_ids][]"]
      }
    }
  end

  def action_event_collection_params
    params.require(:action_event_collection)
  end
end
