# frozen_string_literal: true

# To deliver this notification:
#
# ActionEventReminder.with(post: @post).deliver_later(current_user)
# ActionEventReminder.with(post: @post).deliver(current_user)

class ActionEventReminder < ApplicationNotification
  # Database delivery is already added in ApplicationNotification
  deliver_by :action_cable, format: :to_websocket, channel: "NotificationChannel"

  # Add your delivery methods
  #
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :action_events
  param :account_name
  param :unfinished_action_events

  # Define helper methods to make rendering easier.
  #
  # `message` and `url` are used for rendering in the navbar

  def message
    "account #{account_name} has #{unfinished_action_events.length} unstarted action items. "
  end

  def url
    # You can use any URL helpers here such as:
    # post_path(params[:post])
    root_path
  end

  # Include account_id to make sure notification only triggers if user is signed in to that account
  def to_websocket
    {
      account_id: record.account_id,
      html: ApplicationController.render(partial: "notifications/notification", locals: { notification: record })
    }
  end

  def unfinished_action_events
    params[:unfinished_action_events]
  end

  def account_name
    params[:account_name]
  end
end
