# Overall application controller.
# @todo Review the inclusions
#  It is likely that we do not need to include all libraries
#  specified within this class.
# @author Paul Long
class ApplicationController < ActionController::Base
  helper :all
  include UrlHelper
  protect_from_forgery
  include Userstamp
#  require 'newrelic_rpm'

  # @author Paul Long
  def set_current_user
    User.current = current_user
  end

end
