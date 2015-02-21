class ProfilesController < ApplicationController
  load_and_authorize_resource

  def show
    @comment = current_user.comments.new if user_signed_in?
  end

  def edit
  end

  def update
    unless @profile.update(profile_params)
      flash[:errors] = @profile.errors.to_a
      redirect_to :back
    else
      redirect_to @profile
    end
  end

  def comment
    comment = @profile.comments.create(
      comment: params[:comment][:comment],
      user: current_user
    )
    redirect_to :back
  end

  def erase_avatar
    @profile.avatar = nil
    @profile.save
  end

private
  def profile_params
    params.require(:profile).permit(:name, :surname, :birthday, :contacts, :birthday_hidden,
                    :skype, :skype_hidden, :phone, :phone_hidden, :vk, :vk_hidden, :fb, :fb_hidden, :avatar)
  end
end
