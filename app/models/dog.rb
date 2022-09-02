# frozen_string_literal: true

# == Schema Information
#
# Table name: dogs
#
#  id                  :bigint           not null, primary key
#  birthday            :date
#  name                :string
#  registered_name     :string
#  registration_number :string
#  sex                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  group_id            :bigint           not null
#
# Indexes
#
#  index_dogs_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
class Dog < ApplicationRecord
  include Loggable
  include Eventable
  belongs_to :group

  has_one_attached :avatar
  acts_as_taggable_on :tags
  has_many :action_event_records, as: :eventable, dependent: :destroy
end