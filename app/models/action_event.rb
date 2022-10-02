# frozen_string_literal: true

# == Schema Information
#
# Table name: action_events
#
#  id                 :bigint           not null, primary key
#  description        :string
#  due_date           :datetime         not null
#  recurring_schedule :text
#  status             :integer          default("Not Started"), not null
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :integer          default(0), not null
#
# Indexes
#
#  index_action_events_on_status  (status)
#
class ActionEvent < ApplicationRecord
  serialize :recurring_schedule
  acts_as_taggable_on :tags
  include HasStatus
  acts_as_tenant :account
  acts_as_taggable_tenant :account_id
  has_many :action_event_records, inverse_of: :action_event, dependent: :destroy
  has_many :dogs, through: :action_event_records, source: :eventable, source_type: "Dog"
  accepts_nested_attributes_for :action_event_records

  validates :title, :due_date, presence: true

  def record_changes
    action_event_records.each(&:record_changes)
  end

  def set_finished_status
    update_status_to(status: 3)
  end

  def set_in_progress_status
    update_status_to(status: 2)
  end

  def update_status_to(status: Integer)
    action_event_records.each do |event_record|
      event_record.update_status_to(status:)
    end
    self.status = status
    save
  end
end
