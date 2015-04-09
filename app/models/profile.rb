class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
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
      if not social_avatar.nil? then
        return social_avatar
      end
    end
    return avatar.url(type)
  end

private
  def validate_birthday
    if age <= 18 || age > 100
      errors.add(:birthday, "is incorrect")
    end
  end

  def validate_name
    if name.length < 1
      errors.add(:name, "must not be blank")
    end
    if name.length > 255
      errors.add(:name, "is too long")
    end
    if surname.length < 1
      errors.add(:surname, "must not be blank")
    end
    if surname.length > 255
      errors.add(:surname, "is too long")
    end
  end

  def validate_phone
    return if phone.nil?
    phone.gsub!('-', ' ')
    phone.gsub!('(', ' ')
    phone.gsub!(')', ' ')
    unless /^\+?[\d\s]{0,256}$/ =~ phone
      errors.add(:phone, "is not valid")
    end
  end

end
