# frozen_string_literal: true

class AddPositionToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :position, :integer
    Group.order(:updated_at).each.with_index(1) do |group, index|
      group.update_column :position, index
    end
  end
end
