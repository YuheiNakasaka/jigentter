module ApplicationHelper
  # 便利 http://stackoverflow.com/questions/19595840/rails-get-the-time-difference-in-hours-minutes-and-seconds
  def time_diff(time)
    if time.present?
      seconds_diff = ((time + 1.hour + 1.minutes) - (Time.now)).to_i
      return "まもなく" if seconds_diff < 0
      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600
      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60
      seconds = seconds_diff
      "#{hours.to_s.rjust(2, '0')}時間#{minutes.to_s.rjust(2, '0')}分#{seconds.to_s.rjust(2, '0')}秒"
    end
  end
end
