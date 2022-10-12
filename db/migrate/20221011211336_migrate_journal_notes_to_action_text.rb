# frozen_string_literal: true

class MigrateJournalNotesToActionText < ActiveRecord::Migration[7.0]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :journals, :notes, :content_old
    ActsAsTenant.without_tenant do
      Journal.all.each do |journal|
        journal.update_attribute(:notes, simple_format(journal.content_old))
      end
    end
    remove_column :journals, :content_old
  end

  # def up
  #   rename_column :journals, :notes, :content_old
  #   Post.all.each do |journal|
  #     Journal.update_attribute(:notes, simple_format(journal.content_old))
  #   end
  # end

  # def down
  #   add_column :journals, :content_old, :text
  #   Journal.all.each do |journal|
  #     journal.update_attribute(:content_old, journal.notes.to_plain_text)
  #     journal.notes.delete
  #   end
  #   rename_column :journals, :content_old, :notes
  # end
end
