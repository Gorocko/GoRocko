# frozen_string_literal: true

class TagsController < ApplicationController
  def auto_complete
    list = ActsAsTaggableOn::Tag.named_like(params[:q])

    render(json: list)
  end
end
