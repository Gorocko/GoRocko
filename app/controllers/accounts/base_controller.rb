# frozen_string_literal: true

module Accounts
  class BaseController < ApplicationController
    def require_account_admin
      account_user = @account.account_users.find_by(user: current_user)
      redirect_to @account, alert: t("accounts.admin_required") unless account_user&.admin?
    end
  end
end
