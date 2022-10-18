# frozen_string_literal: true

class StatusBadgeComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
    @class_name = "inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium #{color_config}"
  end

  def color_config
    case @status
    when "Not Started"
      "bg-gray-100 text-gray-800"
    when "In Progress"
      "bg-blue-100 text-blue-800"
    when "Finished"
      "bg-green-100 text-green-800"
    end
  end
end
