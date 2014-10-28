class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_padding_top

private
  def set_padding_top
    @padding_top = 0
    @navbar_style = 'navbar-static-top'
  end

end
