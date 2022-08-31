# frozen_string_literal: true

module HasStatus
  extend ActiveSupport::Concern
  included do
    enum status: {unknown: 0, "Not Started": 1, "In Progress": 2, Finished: 3}
  end
end
