# frozen_string_literal: true

class AddAccountToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :account_id, :integer, default: 0, null: false
    add_column :event_templates, :account_id, :integer, default: 0, null: false
    add_column :groups, :account_id, :integer, default: 0, null: false
    add_column :journals, :account_id, :integer, default: 0, null: false
    add_column :action_event_records, :account_id, :integer, default: 0, null: false
    add_column :action_events, :account_id, :integer, default: 0, null: false
    add_column :event_template_collections, :account_id, :integer, default: 0, null: false
  end
end
