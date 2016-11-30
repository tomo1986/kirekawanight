class ApiController < ActionController::Base
  include ApiHelper
  rescue_from Exception, :with => :render_500
  layout false
end
