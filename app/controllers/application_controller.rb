class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :nav_variables

  private
  def nav_variables
    @current_reel = current_user && current_user.current_reel_slug? && Reel.exists?(current_user.current_reel_slug) ? Reel.find(current_user.current_reel_slug) : nil
    @reels_created = Reel.where("title <> ''").order('created_at DESC').limit(5)
    @reels_updated = Reel.where("title <> ''").order('updated_at DESC').limit(5)
  end
end
