# frozen_string_literal: true

class CreateActionEventRecords < ActiveRecord::Migration[7.0]
  def change
    create_table(:action_event_records) do |t|
      t.integer(:status, null: false, default: 1)
      t.string(:content)
      t.references(:eventable, polymorphic: {default: "Dog"}, null: false)
      t.references(:action_event, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
