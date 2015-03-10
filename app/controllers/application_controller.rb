class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_padding_top
  before_action :update_sanitized_params, if: :devise_controller?

private
  def set_padding_top
    @padding_top = 0
    @navbar_style = 'navbar-static-top'
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation,
                profile_attributes: [:id, :name, :surname, :birthday])
    end
  end

  def after_sign_in_path_for(resource)
    parties_path
  end

end
