# frozen_string_literal: true

class AddLoggableToJournals < ActiveRecord::Migration[7.0]
  def change
    add_reference(:journals, :loggable, polymorphic: true, null: false)
  end
end
