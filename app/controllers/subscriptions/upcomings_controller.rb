# frozen_string_literal: true

module Subscriptions
  class UpcomingsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_account_admin
    before_action :set_subscription

    def show
      @invoice = @subscription.upcoming_invoice
    end

    private

    def set_subscription
      @subscription = current_account.subscriptions.find_by(prefix_id: params[:subscription_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to subscriptions_path
    end
  end
end
