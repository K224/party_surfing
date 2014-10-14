class Profile < ActiveRecord::Base
  belongs_to :user

  acts_as_commentable

  def full_name
    "#{name} #{surname}"
  end

  def age
    ((Date.today - birthday) / 365.0).to_i
  end
end
