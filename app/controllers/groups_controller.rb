# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]
  def index
    @groups = Group.order(position: :asc)
  end

  def edit; end

  def update
    @group.insert_at(group_params[:position].to_i) if group_params[:position].present?
    respond_to do |format|
      if @group.save
        format.json { render(json: format) }
        format.turbo_stream { render(:update, locals: { groups: Group.order(position: :asc) }) }
      else
        format.json { render(json: @dog.errors, status: :unprocessable_entity) }
      end
    end
  end

  def new
    @group = Group.new
  end

  def show; end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        @group.move_to_top
        format.html { redirect_to(groups_path, notice: "Group was successfully created.") }
        format.json { render(:show, status: :created, location: @dog) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @dog.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    default_group = Group.where(name: "default")&.first
    if default_group.present? && @group.id == default_group.id
      redirect_to(groups_url, notice: "Default group is not allowed to be deleted")
      return
    end

    default_group = Group.new(name: "default") if default_group.blank?
    transfer_dogs_from_group(@group, default_group)
    default_group.save
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url, notice: "Group was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def transfer_dogs_from_group(old_group, new_group)
    old_group.dogs.each do |dog|
      dog.group_id = new_group.id
      dog.save
    end
  end

  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :position)
  end
end
