# frozen_string_literal: true

class AddTitleToJournals < ActiveRecord::Migration[7.0]
  def change
    add_column :journals, :title, :string, null: false, default: ""
    add_reference :journals, :author, null: false, foreign_key: { to_table: :users }, default: 1
  end
end
