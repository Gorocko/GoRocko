# frozen_string_literal: true

class DashboardController < ApplicationController
  include ActionEventsHelper
  def show
    @action_event_q = ActionEvent.order(due_date: :desc).ransack(params[:q])
    @pagy, @action_events = pagy(@action_event_q.result(distinct: true))
    @event_template_collections = EventTemplateCollection.all
    render "action_events/index", locals: { action_events: @action_events,
                                            pagy: @pagy,
                                            action_event_q: @action_event_q,
                                            event_template_collections: @event_template_collections }
  end
end
