# frozen_string_literal: true

module TemplateCollection
  class RemoveTemplateCardHeaderComponent < ViewComponent::Base
    def initialize(title:, is_head:)
      @title = title
      @is_head = is_head
    end
  end
end
