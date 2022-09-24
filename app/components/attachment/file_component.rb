# frozen_string_literal: true

module Attachment
  class FileComponent < ViewComponent::Base
    def initialize(file:)
      @file = file
    end
  end
end
