# frozen_string_literal: true

class ChangeDefaultValueGroupPosition < ActiveRecord::Migration[7.0]
  def change
    change_column :groups, :position, :integer, default: 1
  end
end
