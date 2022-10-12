# frozen_string_literal: true

# == Schema Information
#
# Table name: action_event_records
#
#  id              :bigint           not null, primary key
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
  has_rich_text :content
  has_many_attached :photos

  def record_changes(author)
    journal = Journal.create!(title: action_event.title.to_s, notes: content, loggable: eventable, author:)
    journal.photos.attach(photos.map(&:blob))
  end

  def all_future_events(end_time)
    action_event.schedule.occurrences_between(due_date, end_time).flat_map do |occurrence_time|
      if occurrence_time == action_event.due_date
        self
      else
        temp = deep_clone include: [:action_event] do |original, kopy|
          kopy.due_date = occurrence_time
          kopy.id = original.id
          kopy.status = 1
        end
        temp.id = id
        temp.due_date = occurrence_time
        temp
      end
    end
  end

  def update_status_to(status: Integer)
    self.status = status
    save
  end

  def finished?
    status == "Finished"
  end
end
