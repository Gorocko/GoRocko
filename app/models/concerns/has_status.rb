# frozen_string_literal: true

module HasStatus
  extend ActiveSupport::Concern
  included do
    enum status: { 'Not Started': 1, 'In Progress': 2, Finished: 3 }
    def finished?
      status == "Finished"
    end
  end
end
