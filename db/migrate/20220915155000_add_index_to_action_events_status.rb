class AddIndexToActionEventsStatus < ActiveRecord::Migration[7.0]
  def change
    add_index :action_events, :status
  end
end
