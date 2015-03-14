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

  def vote
    if params[:weight].to_i > 5 then
      params[:weight] = "5"
    end
    if params[:weight].to_i < 1 then
      params[:weight] = "1"
    end
    votes = @profile.get_likes(:vote_scope => @current_user.id.to_s)
    if votes.size == 1 then
      @profile.profile_rating_sum -= votes[0].vote_weight
      @profile.profile_rating_num -= 1
    end
    @profile.liked_by @current_user, :vote_weight => params[:weight], :vote_scope => @current_user.id.to_s
    @profile.profile_rating_num += 1
    @profile.profile_rating_sum += params[:weight].to_i
    @profile.save
    redirect_to @profile
  end

private
  def profile_params
    params.require(:profile).permit(:name, :surname, :birthday, :contacts, :birthday_hidden,
                    :skype, :skype_hidden, :phone, :phone_hidden, :vk, :vk_hidden, :fb, :fb_hidden, :avatar)
  end
end
