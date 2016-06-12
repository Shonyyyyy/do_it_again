module RemindersHelper
  def format_frequency(number)
    if number > 2
      "#{number} times"
    else
      if number == 1
        "once"
      else
        "twice"
      end
    end
  end

  def get_latest_date(reminder)
    latest_recent = reminder.recents.order("created_at").last
    latest_recent.created_at.to_formatted_s(:long_ordinal)
  end

  def frequency_rate_formatted(reminder)
    case reminder.repeat
    when "Day"
      cycle = Time.now - 24.hours
    when "Week"
      cycle = Time.now - 7.days
    when "Month"
      cycle = Time.now - 1.month
    when "Year"
      cycle = Time.now - 1.year
    end

    amount = reminder.recents.where("created_at > ?", cycle).count

    case amount
    when 0
      "never"
    when 1
      "once"
    when 2
      "twice"
    else
      "#{amount} times"
    end
  end
end
