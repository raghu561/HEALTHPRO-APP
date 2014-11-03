class Track < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :key, :name, :coordinates, :user_id,:from_address,:to_address,:read_flag
  belongs_to :user

end
