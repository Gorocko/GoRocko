# frozen_string_literal: true

module GroupsView
  class WebViewComponent < ViewComponent::Base
    include Ransack::Helpers::FormHelper
    def initialize(dogs:)
      @dogs = dogs
      @groups = dogs.map(&:group).uniq
    end
  end
end
