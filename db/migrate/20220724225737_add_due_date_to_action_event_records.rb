# frozen_string_literal: true

class AddDueDateToActionEventRecords < ActiveRecord::Migration[7.0]
  def change
    add_column(:action_event_records, :due_date, :datetime)
  end
end
