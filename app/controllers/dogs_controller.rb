# frozen_string_literal: true

class DogsController < ApplicationController
  include TimeDisplayHelper
  include AvatarHelper
  include DogsHelper
  before_action :authenticate_user!
  before_action :set_dog, only: %i[show edit update destroy]
  before_action :handle_group_id, only: %i[create update]

  # GET /dogs or /dogs.json
  def index
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true).includes(:group)
  end

  # GET /dogs/1 or /dogs/1.json
  def show
    @action_event_records = action_event_records_in_order_until(30.days.from_now)
    @action_events = @action_event_records.map(&:action_event)
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
    @primary_button_text = 'Create'
    @secondary_button_text = 'Add another dog'
  end

  # GET /dogs/1/edit
  def edit; end

  # POST /dogs or /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @primary_button_text = 'Create'
    @secondary_button_text = 'Add another dog'
    respond_to do |format|
      if @dog.save
        if button_text_param[:button_text] == @secondary_button_text
          format.html { redirect_to(new_dog_path, success: "Dog was successfully created.") }
        else
          format.html { redirect_to(dog_path(@dog), success: "Dog was successfully created.") }
        end
        format.json { render(:show, status: :created, location: @dog) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @dog.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /dogs/1 or /dogs/1.json
  def update
    @primary_button_text = 'Update'
    @secondary_button_text = ''
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to(dog_path(@dog), success: "Dog was successfully updated.") }
        format.json { render(:show, status: :ok, location: @dog) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @dog.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /dogs/1 or /dogs/1.json
  def destroy
    @dog.avatar.purge
    @dog.destroy

    respond_to do |format|
      format.html { redirect_to(dogs_path, success: "Dog was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dog
    @dog = Dog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dog_params
    @dog_params ||= params.require(:dog).permit(:name, :registered_name,
                                                :registration_number,
                                                :birthday, :notes, :sex, :color_list, :pattern_list,
                                                :group_id, :avatar, :tag_list, append_photos: [], append_files: [])
  end

  def button_text_param
    params.permit(:button_text)
  end
end
