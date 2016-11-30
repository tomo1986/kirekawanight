module ApiHelper

  # render when success data return to client
  def render_success(object = nil, message = nil, response_type = 'json')
    builder = Jbuilder.new do |json|
      json.code 1
      json.data object
      json.message message unless message.nil?
    end
    if response_type == 'json'
      render json: builder.target!
    elsif response_type == 'html'
      render text: builder.target!
    end
  end

  # render when false return to client
  def render_failed(reason_number, message, response_type = 'json')
    logger.debug "doudesuka"
    builder = Jbuilder.new do |json|
      json.code reason_number
      json.message message
    end
    if response_type == 'json'
      render json: builder.target!
    elsif response_type == 'html'
      render text: builder.target!
    end
  end
  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    unless Rails.env == 'production'
      message = "#{exception.message}\n#{exception.backtrace.join("\n")}"
    end

    if exception.kind_of? ActionController::InvalidAuthenticityToken
      message = "invalid authenticity token"
    end
    render_failed(0, message)
  end

  def time_ago(time)
    now = Time.zone.now
    day = (now.day - time.day).abs
    hour = (now.hour - time.hour).abs
    min = (now.min - time.min).abs
    if now.year - time.year == 0
      if (now.month - time.month).abs == 0
        if day == 0
          if hour == 0
            current_time = min == 0 ? I18n.t('time_ago.no_time') : I18n.t('time_ago.minute', min: min)
          else
            current_time = I18n.t('time_ago.hour', hour: hour)
          end
        elsif day == 1
          current_time = I18n.t('time_ago.yesterday') + time.strftime('%H:%M')
        elsif day <= 7
          current_time = I18n.t('time_ago.wday_'+time.wday.to_s) + time.strftime('%H:%M')
        else
          current_time = I18n.t('time_ago.month', month: time.month, day: time.day) + time.strftime('%H:%M')
        end
      else
        current_time = I18n.t('time_ago.month', month: time.month, day: time.day)
      end
    else
      current_time = I18n.t('time_ago.year', year: time.year, month: time.month, day: time.day)
    end
  end

  def each_month(date, end_date)
   ret = []
   date = date.beginning_of_month
   (ret << date; date += 1.month) while date <= end_date
   ret
  end
end
