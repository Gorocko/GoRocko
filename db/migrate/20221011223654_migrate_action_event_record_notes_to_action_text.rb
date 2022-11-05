# frozen_string_literal: true

class MigrateActionEventRecordNotesToActionText < ActiveRecord::Migration[7.0]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :action_event_records, :content, :content_old
    ActsAsTenant.without_tenant do
      ActionEventRecord.all.each do |event|
        event.update_attribute(:content, simple_format(event.content_old))
      end
    end
    remove_column :action_event_records, :content_old
  end
end
