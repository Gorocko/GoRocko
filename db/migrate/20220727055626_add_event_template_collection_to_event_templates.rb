# frozen_string_literal: true

class AddEventTemplateCollectionToEventTemplates < ActiveRecord::Migration[7.0]
  def change
    add_reference(:event_templates, :event_template_collection, null: false, foreign_key: true, default: 0)
  end
end
