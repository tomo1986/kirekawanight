class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth

  def basic_auth
    # authenticate_or_request_with_http_basic('Enter Password') do |u, p|
    #   u == 'kirekawa_dev' && p == 'kirekawa123'
    # end
  end
end
