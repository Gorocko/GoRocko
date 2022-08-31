# frozen_string_literal: true

class AddEventTemplateCollectionTable < ActiveRecord::Migration[7.0]
  def change
    create_table(:event_template_collections) do |t|
      t.string(:title, null: false)
      t.integer(:status, null: false, default: 1)
      t.timestamps
    end

    create_table(:event_templates) do |t|
      t.string(:title)
      t.string(:description)
      t.boolean(:is_head, null: false, default: false)
      t.datetime(:time_delta_from_last)

      t.timestamps
    end
  end
end
