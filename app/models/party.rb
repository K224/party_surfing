class Party < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :type
  has_many :guests, dependent: :destroy

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/party_ava.png",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_visibility => "public",
    :path => "parties/:style/:id_:filename"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  acts_as_commentable

  def check_participation(user)
    guests.find_by(user_id: user.id) != nil
  end

  def get_thumb_url
    return avatar.url(:thumb)
  end


end
