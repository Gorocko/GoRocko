# frozen_string_literal: true

module Attachment
  class PhotoComponent < ViewComponent::Base
    def initialize(photo:)
      @photo = photo
    end
  end
end
