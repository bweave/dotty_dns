module DnsQueriesHelper
  def search_time_frame_options
    { "24h" => 24.hours, "1h" => 1.hour, "7d" => 7.days, "30d" => 30.days }
  end

  def search_time_frame_default
    search_time_frame_options.keys.first
  end

  def search_time_frame
    search_time_frame_options[params[:time_frame] || search_time_frame_default]
  end
end
