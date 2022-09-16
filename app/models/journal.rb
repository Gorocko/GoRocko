# frozen_string_literal: true

# == Schema Information
#
# Table name: journals
#
#  id            :bigint           not null, primary key
#  loggable_type :string           not null
#  notes         :text
#  title         :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :integer          default(0), not null
#  author_id     :bigint           default(1), not null
#  loggable_id   :bigint           not null
#
# Indexes
#
#  index_journals_on_author_id  (author_id)
#  index_journals_on_loggable   (loggable_type,loggable_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Journal < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :loggable, polymorphic: true
  belongs_to :author, class_name: "User"
  has_many_attached :photos
  acts_as_tenant :account
  acts_as_taggable_tenant :account_id

  validates :title, presence: true
end
