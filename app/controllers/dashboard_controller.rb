# frozen_string_literal: true

class DashboardController < ApplicationController
  include ActionEventsHelper
  def show
    @action_events = action_events_in_order_until(30.days.from_now)
    @event_template_collections = EventTemplateCollection.all
    render "action_events/index", locals: { action_events: @action_events,
                                            event_template_collections: @event_template_collections }
  end
end
