class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :current_reel

  private
  def current_reel
    @current_reel = current_user && current_user.current_reel_slug? && Reel.exists?(current_user.current_reel_slug) ? Reel.find(current_user.current_reel_slug) : nil
  end
end
