class PartiesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:create, :get_parties_in_zone, :index]

  def index
    if params[:user_id] == nil
      @padding_top = '78px'
      @navbar_style = 'navbar-fixed-top'
      @party = Party.new
    else
      @user = User.find(params[:user_id])
      render 'user_parties'
    end
  end

  def show
    @comment = current_user.comments.new if can? :comment, @party
    @party = @party.decorate
  end

  def edit
  end

  def new
    @padding_top = '80px'
    @navbar_style = 'navbar-fixed-top'
  end

  def update
    unless @party.update(party_params)
      flash[:errors] = @party.errors.to_a
      redirect_to :back
    else
      redirect_to @party
    end
  end

  def destroy
    @party.destroy
    redirect_to current_user.profile
  end

  def create
    params[:party][:host_id] = current_user.id
    @party = Party.new(party_creation_params)
    unless @party.save
      flash[:errors] = @party.errors.to_a
      redirect_to :back
    else
      redirect_to @party
    end
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

  def comment
    comment = @party.comments.create(
      comment: params[:comment][:comment],
      user: current_user
    )
    redirect_to :back
  end

  def get_parties_in_zone
    zone = params[:zone].split(',')
    parties = Party.where(
      "date >= ? AND coord_latitude >= ? AND coord_longitude >= ? AND coord_latitude <= ? AND coord_longitude <= ?",
      Date.today, zone[0], zone[1], zone[2], zone[3])
    render json: parties.to_json(:methods => [:get_thumb_url, :tag_list], :include => {host: { include: :profile}})
  end

  def autocomplete_tags
    q = params[:term] || ""
    tags = ActsAsTaggableOn::Tag.where("name LIKE ?", "%#{q}%")
      .most_used.collect { |tag| tag.name }
    render json: tags
  end

private
  def party_params
    params.require(:party).permit(:title, :type, :date, :summary,
                                  :description, :coord_latitude,
                                  :coord_longitude, :avatar, :tag_list => [])
  end

  def party_creation_params
    params.require(:party).permit(:title, :host_id, :coord_latitude,
                                  :coord_longitude, :date, :type_id,
                                  :summary, :avatar, :tag_list => [])
  end
end
