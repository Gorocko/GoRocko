# frozen_string_literal: true

class ActionEventsController < ApplicationController
  include ActionEventsHelper
  before_action :authenticate_user!
  before_action :set_action_event, only: %i[show destroy edit take_action update]
  def index
    @action_events = action_events_in_order_until(30.days.from_now)
    @event_template_collections = EventTemplateCollection.all
  end

  def new
    @action_event = ActionEvent.new
    @action_event.action_event_records.build
  end

  def show; end

  def destroy
    @action_event.destroy

    respond_to do |format|
      format.html { redirect_to(action_events_path, notice: "Reminder was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def edit; end

  def update
    action_event_form = ActionEventForm.new(action_event_params)
    action_event_form.update_reminder(action_event_to_update: @action_event)
    respond_to do |format|
      if action_event_form.save
        format.html { redirect_to(action_event_path(@action_event), success: "Event was successfully updated.") }
        format.json { render(:show, status: :ok, location: @action_event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: action_event_form.errors, status: :unprocessable_entity) }
      end
    end
  end

  def take_action
    @in_progress_button_text = "Save in Progress"
    @finish_task_button_text = "Mark as Finished"
    if request.method == "GET"
      render(TakeActionPageComponent.new(action_event: @action_event,
                                         in_progress_button_text: @in_progress_button_text,
                                         finish_task_button_text: @finish_task_button_text,
                                         main_app:))
    end
    if request.method == "POST"
      if @action_event.update(take_action_params)
        if button_text_param[:button_text] == @finish_task_button_text
          @action_event.finish_event(current_user)
          respond_to do |format|
            format.turbo_stream { redirect_to(action_events_path) }
            format.html { redirect_to(action_events_path) }
          end
        else
          @action_event.set_in_progress_status
          respond_to do |format|
            format.turbo_stream do
              flash.now[:success] = "Progress Successfully Saved."
            end
            format.html { redirect_to(action_events_path) }
          end
        end
      else
        redirect_to(take_action_action_event_path(@action_event))
      end
    end
  end

  def create
    action_event_form = ActionEventForm.new(action_event_params)
    respond_to do |format|
      if action_event_form.save
        format.html do
          redirect_to(action_event_path(action_event_form.action_event),
                      success: "Event Successfully Updated!")
        end
      else

        format.html do
          render ::ActionEvents::ActionEventFormComponent.new(action_event: action_event_form.action_event,
                                                              button_disabled: false,
                                                              main_app:),
                 status: :unprocessable_entity
        end
        format.json { render(json: action_event_form.errors, status: :unprocessable_entity) }
      end
    end
  end

  def action_event_params
    params.require(:action_event).permit(:title, :due_date, :description, :tag_list,
                                         action_event_records: {
                                           eventable_ids: []
                                         },
                                         occurrence_schedule: {})
  end

  def take_action_params
    params.require(:action_event).permit(action_event_records_attributes: {})
  end

  def set_action_event
    @action_event = ActionEvent.find(params[:id])
  end

  def button_text_param
    params.permit(:button_text)
  end
end
