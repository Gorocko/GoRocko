# frozen_string_literal: true

class JournalsController < ApplicationController
  before_action :set_journal, only: %i[show edit update destroy]
  before_action :set_dog, only: %i[new create]

  def show; end

  def new
    @journal = Journal.new
    @journal.created_at = Time.zone.now
  end

  def create
    @journal = Journal.new(journal_params)
    @journal.update(loggable: @dog, author: current_user)
    if @journal.save
      flash[:success] = "Object successfully created"
      redirect_to(@dog)
    else
      render(:new, status: :unprocessable_entity)
      flash[:error] = "Something went wrong"
    end
  end

  def edit
    @dog = @journal.loggable
  end

  def update
    # TODO: check if user can access this
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to(journal_url(@journal), success: "Dog was successfully updated.") }
        format.json { render(:show, status: :ok, location: @journa) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @journal.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    dog = @journal.loggable
    @journal.destroy
    @journal.photos(&:purge)

    respond_to do |format|
      format.html { redirect_to(dog_url(dog), success: "journal was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end

  def journal_params
    params.require(:journal).permit(:title, :notes, :tag_list, :created_at, append_photos: [])
  end
end
