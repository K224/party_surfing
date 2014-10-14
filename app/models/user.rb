class User < ActiveRecord::Base

  has_one :profile
  has_many :parties, foreign_key: 'host_id'
  has_many :participations, class_name: 'Guest'
  has_many :comments

  before_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
