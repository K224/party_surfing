class ProfilesController < ApplicationController
  load_and_authorize_resource

  def show
    @comment = current_user.comments.new if user_signed_in?
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    redirect_to @profile
  end

  def comment
    comment = @profile.comments.create(
      title: params[:comment][:title],
      comment: params[:comment][:comment],
      user: current_user
    )
    redirect_to :back
  end

private
  def profile_params
    params.require(:profile).permit(:name, :surname, :birthday, :contacts)
  end
end
