# frozen_string_literal: true

class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table(:dogs) do |t|
      t.string(:name)
      t.string(:registered_name)
      t.string(:registration_number)
      t.date(:birthday)
      t.string(:sex)
      t.string(:picture_url)

      t.timestamps
    end
  end
end
