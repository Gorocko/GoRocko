# frozen_string_literal: true

class AttachmentController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  def destroy
    @attachment.purge
    flash.now[:success] = "Picture successfully deleted"
  end

  def find_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end
