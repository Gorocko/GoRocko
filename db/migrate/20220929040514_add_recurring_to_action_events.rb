# frozen_string_literal: true

class AddRecurringToActionEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :action_events, :recurring_schedule, :text
  end
end
