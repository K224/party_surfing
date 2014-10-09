class Guest < ActiveRecord::Base
  belongs_to :party
  belongs_to :user

  def accept!
    self.accepted = !accepted
    save
  end
end
