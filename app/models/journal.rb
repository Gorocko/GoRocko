# frozen_string_literal: true

# == Schema Information
#
# Table name: journals
#
#  id            :bigint           not null, primary key
#  loggable_type :string           not null
#  notes         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :integer          default(0), not null
#  loggable_id   :bigint           not null
#
# Indexes
#
#  index_journals_on_loggable  (loggable_type,loggable_id)
#
class Journal < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :loggable, polymorphic: true
  has_many_attached :photos
  acts_as_tenant :account
  acts_as_taggable_tenant :account_id
end
