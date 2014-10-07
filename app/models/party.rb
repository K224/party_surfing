class Party < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :type
  has_many :guests

end
