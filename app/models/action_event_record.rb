# frozen_string_literal: true

# == Schema Information
#
# Table name: action_event_records
#
#  id              :bigint           not null, primary key
#  content         :string
#  due_date        :datetime
#  eventable_type  :string           default("Dog"), not null
#  status          :integer          default("Not Started"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :integer          default(0), not null
#  action_event_id :bigint           not null
#  eventable_id    :bigint           not null
#
# Indexes
#
#  index_action_event_records_on_action_event_id  (action_event_id)
#  index_action_event_records_on_eventable        (eventable_type,eventable_id)
#
# Foreign Keys
#
#  fk_rails_...  (action_event_id => action_events.id)
#
class ActionEventRecord < ApplicationRecord
  include HasStatus
  acts_as_tenant :account
  belongs_to :eventable, polymorphic: true
  belongs_to :action_event
  has_many_attached :photos

  def record_changes
    log_info = "Title: #{action_event.title} \n
                Description:  #{action_event.description} \n
                Reminder due date: #{due_date} \n
                Notes: #{content} \n
    "
    journal = Journal.create!(notes: log_info, loggable: eventable, author: current_user)
    journal.photos.attach(photos.map(&:blob))
  end

  def update_status_to(status: Integer)
    self.status = status
    save
  end

  def finished?
    status == "Finished"
  end
end
