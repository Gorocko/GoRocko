# frozen_string_literal: true

class AddGroupRefToDogs < ActiveRecord::Migration[7.0]
  def change
    add_reference(:dogs, :group, null: false, foreign_key: true)
  end
end
