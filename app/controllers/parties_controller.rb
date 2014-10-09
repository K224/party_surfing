class PartiesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:create]

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

  def get_parties_in_zone
  end

private
  def party_params
    params.require(:party).permit(:title, :description)
  end

  def party_creation_params
    params.require(:party).permit(:title, :host_id, :coord_latitude,
                                  :coord_longitude, 'date(1i)',
                                  'date(2i)', 'date(3i)', :type_id, :summary)
  end
end
