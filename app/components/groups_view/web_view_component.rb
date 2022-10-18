# frozen_string_literal: true

module GroupsView
  class WebViewComponent < ViewComponent::Base
    def initialize(groups:)
      @groups = groups
    end
  end
end
