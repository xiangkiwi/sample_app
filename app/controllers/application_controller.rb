class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :switch_locale
  # it run around all action run. this is filter action technical

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def switch_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".login_remind"
    redirect_to login_path
  end
end
