# frozen_string_literal: true

class OccurrenceComponent < ViewComponent::Base
  def initialize(form:, recurring_schedule:)
    @form = form
    @never_option_checked = false
    @recurring_schedule = recurring_schedule
    @date_option_checked = false
    @count_option_checked = false
    @count_option_value = nil
    @date_option_value = nil

    until_option_check
    if recurring_schedule
      @occurrence_interval = recurring_schedule[:rrules].first[:interval]
      @occurrence_interval_option = map_to_option(recurring_schedule[:rrules].first[:rule_type])
    end
  end

  def until_option_check
    if @recurring_schedule
      recurring_schedule_rule = @recurring_schedule[:rrules].first
      if recurring_schedule_rule[:count].present?
        @count_option_checked = true
        @count_option_value = recurring_schedule_rule[:count]
      elsif recurring_schedule_rule[:until].present?
        @date_option_checked = true
        @date_option_value = recurring_schedule_rule[:until][:time].to_date
      else
        @never_option_checked = true
      end
    else
      @never_option_checked = true

    end
  end

  def map_to_option(rule_type)
    case rule_type
    when "IceCube::DailyRule"
      :days
    when "IceCube::WeeklyRule"
      :weeks
    when "IceCube::MonthlyRule"
      :months
    else
      :years
    end
  end
end
