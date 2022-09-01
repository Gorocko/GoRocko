# frozen_string_literal: true

class EventRecordRowComponent < ViewComponent::Base
  def initialize(event_record_form:)
    @event_record_form = event_record_form
  end
end
