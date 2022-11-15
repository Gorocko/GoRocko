# frozen_string_literal: true

class ActionEventReminderJob
  include Sidekiq::Job

  def perform
    Account.all.each { |account| send_reminder_for_account(account) }
  end

  def send_reminder_for_account(account)
    ActsAsTenant.current_tenant = account
    recipient = account.owner
    Current.user = account.owner

    unfinished_action_events = ActionEvent.where(status: "Not Started").where(
      due_date: (Time.zone.today)..(Time.zone.today + 1.day)
    ).to_a
    return unless unfinished_action_events.length.positive?

    ActionEventReminder.with(account_name: account.name, unfinished_action_events:).deliver(recipient)
  end
end
