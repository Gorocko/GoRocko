# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    @action_events = ActionEvent.all
    render 'action_events/index', locals: { action_events: @action_events }
  end
end
