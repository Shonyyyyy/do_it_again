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

  def frequency_rate_formatted(amount)
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
