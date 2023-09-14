# Standard Rails Application Controller
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action { @pagy_locale = params[:locale] || I18n.default_locale }

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :enable_hotflash

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
