# frozen_string_literal: true

module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :action_event_records, as: :eventable, dependent: :destroy
  end
end
