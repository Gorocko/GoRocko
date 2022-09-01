# frozen_string_literal: true

class EventActionCellComponent < ViewComponent::Base
  def initialize(event_record_form:)
    @event_record_form = event_record_form
  end
end
