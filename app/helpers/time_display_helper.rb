# frozen_string_literal: true

module TimeDisplayHelper
  def formatted_time_display(time)
    return '' if time.nil?

    time.strftime("%m/%d/%Y %H:%M:%S %Z")
  end
end
