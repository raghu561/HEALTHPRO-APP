class UserDoctor < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :doctor_id
end
