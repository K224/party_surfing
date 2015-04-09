class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth
  end

  def vkontakte
    auth
  end

  protected
  def auth
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.nil?
      flash[:alert] = I18n.t('activerecord.attributes.user.email') + ' ' + I18n.t('activerecord.errors.models.user.attributes.email.taken')
      redirect_to new_user_session_path
      return
    end

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.user_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
