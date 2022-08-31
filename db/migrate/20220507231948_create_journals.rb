# frozen_string_literal: true

class CreateJournals < ActiveRecord::Migration[7.0]
  def change
    create_table(:journals) do |t|
      t.text(:notes)
      t.text(:picture_urls)

      t.timestamps
    end
  end
end
