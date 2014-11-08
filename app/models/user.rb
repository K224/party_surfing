class User < ActiveRecord::Base

  has_one :profile
  has_many :parties, foreign_key: 'host_id'
  has_many :participations, class_name: 'Guest'
  has_many :comments

  before_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    if user.nil?
      user = User.find_by(email: auth.info.email)
      return nil unless user.nil?
      user = User.create!(email: auth.info.email,
                         password: Devise.friendly_token[0,20],
                         provider: auth.provider, uid: auth.uid)
      user.profile.update(name: auth.info.first_name,
                         surname: auth.info.last_name)
    end
    return user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session["devise.user_data"] != nil && data = session["devise.user_data"]["info"]
        user.email = data["email"] if user.email.blank?
        user.profile.update(name: data["first_name"], lastname: data["last_name"])
      end
    end
  end

end
