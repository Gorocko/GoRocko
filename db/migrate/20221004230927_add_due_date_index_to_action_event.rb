# frozen_string_literal: true

class AddDueDateIndexToActionEvent < ActiveRecord::Migration[7.0]
  def change
    add_index :action_events, :due_date
  end
end
