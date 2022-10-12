# frozen_string_literal: true

class ChangeUserAdminDefaultValueMigrateExistingUser < ActiveRecord::Migration[7.0]
  def change
    ActsAsTenant.without_tenant do
      User.all.each do |user|
        user.update_attribute(:admin, false) if user.admin.nil?
      end
    end
  end
end
