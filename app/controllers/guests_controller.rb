class GuestsController < ApplicationController
  load_and_authorize_resource :party
  load_and_authorize_resource :guest, through: :party

  def index
  end

  def update
    @guest.accept!
    redirect_to :back
  end
end
