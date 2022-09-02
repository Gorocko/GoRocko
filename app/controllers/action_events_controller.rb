# frozen_string_literal: true

class ActionEventsController < ApplicationController
  include ActionEventsHelper
  before_action :set_action_event, only: [:show, :destroy, :edit, :take_action, :update]
  def index
    @action_events = ActionEvent.all
  end

  def new
    @action_event = ActionEvent.new
    @action_event.action_event_records.build
  end

  def show
  end

  def destroy
    @action_event.destroy

    respond_to do |format|
      format.html { redirect_to(action_events_path, notice: "Reminder was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def edit
  end

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
        finish_task_button_text: @finish_task_button_text))
    end
    if request.method == "POST"
      if @action_event.update(take_action_params)
        if button_text_param[:button_text] == @finish_task_button_text
          @action_event.set_finished_status
          @action_event.record_changes
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
    if action_event_form.save
      redirect_to(action_event_path(action_event_form.action_event),
        success: "Event Successfully Updated!")
    else
      redirect_to(action_events_path)
    end
  end

  def action_event_params
    params.require(:action_event).permit(:title, :due_date, :description, :tag_list,
      action_event_records: {eventable_ids: []})
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