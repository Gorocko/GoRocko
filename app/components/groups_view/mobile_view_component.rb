# frozen_string_literal: true

module GroupsView
  class MobileViewComponent < ViewComponent::Base
    include Ransack::Helpers::FormHelper
    include Pagy::Frontend
    include ApplicationHelper

    def initialize(dogs:, q:, pagy:)
      @dogs = dogs
      @pagy = pagy
      @q = q
      @group_with_dogs = @dogs.map { |d| [d.group, d] }
                              .each_with_object({}) { |(k, v), h| h.update(k => [v]) { |_, o, n| o + n } }
    end
  end
end
