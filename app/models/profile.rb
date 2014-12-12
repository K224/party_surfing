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

  validate :validate_birthday, :validate_name

  acts_as_commentable

  def full_name
    "#{name} #{surname}"
  end

  def age
    ((Date.today - birthday) / 365.0).to_i
  end

private
  def validate_birthday
    if age < 1 || age > 100
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

end
