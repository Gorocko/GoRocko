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
#  index_action_events_on_due_date  (due_date)
#  index_action_events_on_status    (status)
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

  def record_changes(author)
    action_event_records.each do |action_event_record|
      action_event_record.record_changes(author)
    end
  end

  def set_finished_status
    update_status_to(status: 3)
  end

  def set_in_progress_status
    update_status_to(status: 2)
  end

  def schedule
    if recurrent?
      # recurrent schedule
      IceCube::Schedule.from_hash(recurring_schedule)
    else
      # one time schedule
      IceCube::Schedule.new(due_date)
    end
  end

  def finish_event(user)
    if recurrent? && schedule.next_occurrence(due_date)&.to_datetime
      next_due_date = schedule.next_occurrence(due_date)&.to_datetime

      temp_copy = deep_clone include: [:dogs] do |original, kopy|
        kopy.tag_list = original.tag_list if original.respond_to?(:tag_list)
      end
      temp_copy.set_finished_status
      temp_copy.record_changes(user)
      temp_copy.save
      self.due_date = next_due_date

      new_schedule = schedule
      new_schedule.start_time = next_due_date
      if schedule.rrules[0]&.occurrence_count
        previous_count = [new_schedule.rrules[0]&.occurrence_count, 1].max
        new_schedule.rrules[0]&.count(previous_count - 1)
      end
      self.recurring_schedule = new_schedule
      save
    else
      set_finished_status
      record_changes(user)
    end
  end

  def all_future_events(end_time)
    schedule.occurrences_between(due_date, end_time).flat_map do |occurrence_time|
      if occurrence_time == due_date
        self
      else
        temp = deep_clone include: [:dogs] do |original, kopy|
          kopy.tag_list = original.tag_list
        end
        temp.id = id
        temp.due_date = occurrence_time
        temp
      end
    end
  end

  def recurrent?
    recurring_schedule.present?
  end

  def update_status_to(status: Integer)
    action_event_records.each do |event_record|
      event_record.update_status_to(status:)
    end
    self.status = status
    save
  end
end
