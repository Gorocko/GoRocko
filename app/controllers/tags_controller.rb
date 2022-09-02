# frozen_string_literal: true

class TagsController < ApplicationController
  def auto_complete
    list = ActsAsTaggableOn::Tag.for_tenant(current_account.id).named_like(params[:q])
    render(json: list)
  end
end
