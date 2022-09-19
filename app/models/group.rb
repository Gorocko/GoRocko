# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer          default(0), not null
#
class Group < ApplicationRecord
  has_many :dogs
  acts_as_tenant :account
  acts_as_list
end
