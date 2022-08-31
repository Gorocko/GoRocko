# frozen_string_literal: true

class RemovePictureUrlsFromJournals < ActiveRecord::Migration[7.0]
  def change
    remove_column(:journals, :picture_urls, :text)
  end
end
