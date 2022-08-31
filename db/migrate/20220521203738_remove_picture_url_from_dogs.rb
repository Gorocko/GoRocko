# frozen_string_literal: true

class RemovePictureUrlFromDogs < ActiveRecord::Migration[7.0]
  def change
    remove_column(:dogs, :picture_url, :string)
  end
end
