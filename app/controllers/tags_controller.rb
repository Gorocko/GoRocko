# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :authenticate_user!
  def auto_complete
    list = ActsAsTaggableOn::Tag.for_context(:tags).for_tenant(current_account.id).named_like(params[:q])
    render(json: list)
  end
end
