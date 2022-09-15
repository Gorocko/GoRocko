# frozen_string_literal: true

class CheckDueActionEventsForAll
  class << self
    def run
      all_accounts = Account.all
      all_accounts.each do |account|
        ActionEventReminderJob.perform_async(account.id)
      end
    end
  end
end
