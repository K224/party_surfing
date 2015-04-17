class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "80x80#" },
    :default_url => "/images/ava.jpg",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_visibility => "public",
    :path => "profiles/:style/:id_:filename"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validate :validate_birthday, :validate_name, :validate_phone

  acts_as_commentable
  acts_as_votable

  def full_name
    "#{name} #{surname}"
  end

  def age
    return 0 if birthday.nil?
    ((Date.today - birthday) / 365.0).to_i
  end

  def get_avatar(type)
    if avatar_file_name.nil? then
      if not thumb_social_avatar.nil? then
        if type == :thumb then
          return thumb_social_avatar
        else
          return medium_social_avatar
        end
      end
    end
    return avatar.url(type)
  end

private
  def validate_birthday
    if age <= 18 || age > 100
      errors.add(:birthday)
    end
  end

  def validate_name
    if name.length < 1
      errors.add(:name, :blank)
    end
    if name.length > 255
      errors.add(:name, :too_long)
    end
    if surname.length < 1
      errors.add(:surname, :blank)
    end
    if surname.length > 255
      errors.add(:surname, :too_long)
    end
  end

  def validate_phone
    return if phone.nil?
    phone.gsub!('-', ' ')
    phone.gsub!('(', ' ')
    phone.gsub!(')', ' ')
    unless /^\+?[\d\s]{0,256}$/ =~ phone
      errors.add(:phone)
    end
  end

end
