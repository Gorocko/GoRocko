# frozen_string_literal: true

class CreateActionEvents < ActiveRecord::Migration[7.0]
  def change
    create_table(:action_events) do |t|
      t.string(:title, null: false)
      t.string(:description)
      t.datetime(:due_date, null: false)
      t.integer(:status, null: false, default: 1)

      t.timestamps
    end
  end
end
