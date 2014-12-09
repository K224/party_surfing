class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/ava.jpg",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_visibility => "public",
    :path => ":style/:id_:filename"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  acts_as_commentable

  def full_name
    "#{name} #{surname}"
  end

  def age
    ((Date.today - birthday) / 365.0).to_i
  end
end
