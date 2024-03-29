# frozen_string_literal: true

module Turbo
  module Ios
    class PathConfigurationsController < ApplicationController
      # Defines the tabs and rules for the mobile app views
      # To customize this, you can edit the JSON here
      def show
        render json: {
          settings: {
            register_with_account: Jumpstart.config.register_with_account?,
            require_authentication: false,
            tabs: [
              {
                title: "Home",
                path: root_path,
                ios_system_image_name: "house"
              },
              {
                title: "Dogs",
                path: groups_path,
                ios_system_image_name: "pawprint"
              },
              {
                title: "Notifications",
                path: notifications_path,
                ios_system_image_name: "bell",
                show_notification_badge: true
              }
            ]
          },
          rules: [
            {
              patterns: ["/new$", "/edit$"],
              properties: {
                presentation: "modal"
              }
            },
            {
              patterns: ["/users/sign_up"],
              properties: {
                flow: "registration"
              }
            },
            {
              patterns: ["/users/sign_in"],
              properties: {
                flow: "authentication"
              }
            },
            {
              patterns: ["/account/password/edit"],
              properties: {
                flow: "update_password"
              }
            }
          ]
        }
      end
    end
  end
end
