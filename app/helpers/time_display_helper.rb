# frozen_string_literal: true

module TimeDisplayHelper
  def formatted_time_display(time)
    time.strftime("%d/%m/%Y %H:%M:%S %Z")
  end
end
