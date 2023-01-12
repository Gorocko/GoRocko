# frozen_string_literal: true

module Subscriptions
  class CancelsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_account_admin
    before_action :set_subscription

    def show; end

    def destroy
      @subscription.cancel

      # Optionally, you can cancel immediately
      # current_account.subscription.cancel_now!

      redirect_to subscriptions_path, status: :see_other
    rescue Pay::Error => e
      flash[:alert] = e.message
      render :show, status: :unprocessable_entity
    end

    private

    def set_subscription
      @subscription = current_account.subscriptions.find_by(prefix_id: params[:subscription_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to subscriptions_path
    end
  end
end
