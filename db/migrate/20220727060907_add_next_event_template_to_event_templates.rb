# frozen_string_literal: true

class AddNextEventTemplateToEventTemplates < ActiveRecord::Migration[7.0]
  def change
    add_reference(:event_templates, :last_event_template, foreign_key: { to_table: :event_templates })
  end
end
