class Party < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :type
  has_many :guests, dependent: :destroy

  has_attached_file :avatar,
    :styles => { :medium => "300x300#", :thumb => "100x100#" },
    :default_url => "/images/party_ava.png",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_visibility => "public",
    :path => "parties/:style/:id_:filename"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validate :validate_coor, :validate_date, :validate_title

  acts_as_commentable
  acts_as_taggable
  acts_as_votable

  def check_participation(user)
    guests.find_by(user_id: user.id) != nil
  end

  def get_thumb_url
    return avatar.url(:thumb)
  end

private
  def validate_coor
    if(coord_latitude < -180 || coord_latitude > 180 ||
      coord_longitude < -180 || coord_longitude > 180)
      errors.add(:base, "coordinates are incorrect")
    end
  end

  def validate_date
    if date.nil?
      errors.add(:date, "is not set")
    elsif Date.today >= date
      errors.add(:date, "must be at least tomorrow")
    end
  end

  def validate_title
    if title.length < 1
      errors.add(:title, "must not be blank")
    end
    if title.length > 255
      errors.add(:title, "is too long")
    end
  end

end
