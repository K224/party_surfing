class Party < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :type
  has_many :guests, dependent: :destroy

  def check_participation(user)
    guests.find_by(user_id: user.id) != nil
  end

end
