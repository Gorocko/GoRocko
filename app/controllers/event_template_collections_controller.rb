# frozen_string_literal: true

class EventTemplateCollectionsController < ApplicationController
  include EventTemplateCollectionsHelper
  before_action :authenticate_user!
  before_action :set_template_collection, only: %i[show edit destroy update apply]

  def new
    @event_template_collection = EventTemplateCollection.new
    @event_template_collection.event_templates.build
    @event_template_collection.event_templates[0].is_head = true
  end

  def index
    @event_template_collections = EventTemplateCollection.all
  end

  def create
    form = EventTemplateCollectionForm.new(event_template_collection_params)
    if form.save
      redirect_to(event_template_collection_path(form.event_template_collection))
    else
      # TODO:
      redirect_to(event_template_collections_path, error: "Something went wrong, please fill out title")
      # render ::TemplateCollection::TemplateCollectionFormComponent.new(event_template_collection: form.event_template_collection), status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    event_template_collection_form = EventTemplateCollectionForm.new(event_template_collection_params,
                                                                     @event_template_collection)
    event_template_collection_form.update
    if event_template_collection_form.save
      redirect_to(event_template_collection_path(@event_template_collection))
    else
      redirect_to(event_template_collections_path)
    end
  end

  def apply
    render("event_template_collections/apply") if request.method == "GET"
    if request.method == "POST"
      permitted_params = event_template_collection_apply_params

      action_events = apply_event_template_collection(due_date: permitted_params[:due_date],
                                                      selected_dogs: permitted_params[:selected_dogs],
                                                      event_template_collection: @event_template_collection)
      render("event_template_collections/batch_edit", locals: { action_events: })
    end
  end

  def destroy
    @event_template_collection.destroy

    respond_to do |format|
      format.html { redirect_to(event_template_collections_path, notice: "Template was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def show; end

  def event_template_collection_params
    params.require(
      :event_template_collection
    ).permit(
      :title,
      event_templates_attributes: %i[title days_delta_from_last description _destroy id]
    )
  end

  def event_template_collection_apply_params
    params.require(:event_template_collection).permit(:due_date, selected_dogs: [])
  end

  def set_template_collection
    @event_template_collection = EventTemplateCollection.find(params[:id])
  end
end
