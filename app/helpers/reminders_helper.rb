module RemindersHelper
  def format_frequency number
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

  def get_latest_date reminder
    latest_recent = reminder.recents.order("created_at").last
    latest_recent.created_at.to_formatted_s(:long_ordinal) 
  end

end
