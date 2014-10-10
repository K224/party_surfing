class ProfilesController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    redirect_to @profile
  end

private
  def profile_params
    params.require(:profile).permit(:name, :surname, :birthday, :contacts)
  end
end
