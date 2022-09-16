# frozen_string_literal: true

class ErrorsBadgeComponent < ViewComponent::Base
  def initialize(errors:)
    @errors = errors
  end
end
