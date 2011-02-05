class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  def set_locale
    session[:locale] = params[:locale] if params[:locale] && I18n.available_locales.map(&:to_s).include?(params[:locale]) 
    I18n.locale = session[:locale] || I18n.default_locale
  end
  
end
