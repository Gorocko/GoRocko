# frozen_string_literal: true

class ActionEventReminderJob
  include Sidekiq::Job

  def perform(account_id)
    account = Account.find(account_id)
    ActsAsTenant.current_tenant = account
    recipient = account.owner

    unfinished_action_events = ActionEvent.where(status: "Not Started").to_a
    ActionEventReminder.with(account_name: account.name,
                             unfinished_action_events:).deliver(recipient)
  end
end
