class User < ActiveRecord::Base

  has_one :profile
  has_many :parties, foreign_key: 'host_id'
  has_many :participations, class_name: 'Guest'
  has_many :comments

  accepts_nested_attributes_for :profile

  #before_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  def with_profile
    self.build_profile
    self
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    if user.nil?
      user = User.find_by(email: auth.info.email)
      return nil unless user.nil?
      bday = auth.extra.raw_info.birthday || auth.extra.raw_info.bdate
      format = '%d.%m.%Y'
      format = '%m/%d/%Y' unless auth.extra.raw_info.birthday.nil?
      med_avatar = nil
      thumb_avatar = nil
      if auth.provider == "vkontakte" then
        med_avatar = auth.extra.raw_info.photo_200_orig
        thumb_avatar = auth.extra.raw_info.photo_100
      else
        med_avatar = "http://graph.facebook.com/" + auth.info.id.to_s + "picture?type=large"
        thumb_avatar = "http://graph.facebook.com/" + auth.info.id.to_s + "picture?type=small"
      end
      user = User.create!(email: auth.info.email,
                         password: Devise.friendly_token[0,20],
                         provider: auth.provider, uid: auth.uid)
      user.create_profile(name: auth.info.first_name,
                         surname: auth.info.last_name,
                         birthday: Date.strptime(bday,format),
                         thumb_social_avatar: thumb_avatar,
                         medium_social_avatar: med_avatar
                         )
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
