# frozen_string_literal: true

# == Schema Information
#
# Table name: event_template_collections
#
#  id         :bigint           not null, primary key
#  status     :integer          default("Active"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class EventTemplateCollection < ApplicationRecord
  enum status: {unknown: 0, Active: 1, Draft: 2}

  has_many :event_templates, inverse_of: :event_template_collection, dependent: :delete_all
  accepts_nested_attributes_for :event_templates, allow_destroy: true
end
