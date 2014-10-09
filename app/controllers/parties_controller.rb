class PartiesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:create, :get_parties_in_zone]

  def index
  end

  def show
    @party = @party.decorate
  end

  def edit
  end

  def new
  end

  def update
    @party.update(party_params)
    redirect_to @party
  end

  def destroy
    @party.destroy
    redirect_to current_user.profile
  end

  def create
    params[:party][:host_id] = current_user.id
    @party = Party.create(party_creation_params)
    redirect_to @party
  end

  def participate
    if params[:a] == 'participate'
      @party.guests.create(user: current_user, accepted: false)
    else
      p = @party.guests.find_by(user_id: current_user.id)
      p.destroy if p != nil
    end
    redirect_to :back
  end

  def get_parties_in_zone
  end

private
  def party_params
    params.require(:party).permit(:title, :type, :date, :summary, :description)
  end

  def party_creation_params
    params.require(:party).permit(:title, :host_id, :coord_latitude,
                                  :coord_longitude, :date, :type_id, :summary)
  end
end
