# frozen_string_literal: true

json.extract!(dog, :id, :name, :registered_name, :registration_number, :birthday, :sex, :created_at, :updated_at)
json.url(dog_url(dog, format: :json))
