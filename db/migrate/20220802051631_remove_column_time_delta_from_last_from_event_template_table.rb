# frozen_string_literal: true

class RemoveColumnTimeDeltaFromLastFromEventTemplateTable < ActiveRecord::Migration[7.0]
  def change
    remove_column(:event_templates, :time_delta_from_last, :datetime)
    add_column(:event_templates, :days_delta_from_last, :integer)
  end
end
