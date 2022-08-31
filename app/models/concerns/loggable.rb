# frozen_string_literal: true

module Loggable
  extend ActiveSupport::Concern

  included do
    has_many :journals, as: :loggable, dependent: :destroy
  end
end
