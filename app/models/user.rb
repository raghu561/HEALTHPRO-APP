class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :unread_count ,:gender, :city, :state, :address, :zip, :dob, :emergency_contact_name, :emergency_contact_phone, :email, :password, :password_confirmation, :remember_me, :name, :phone, :longitude, :lattitude, :role, :user_type
  # attr_accessible :title, :body
  has_many :tracks
  has_many :patient_consultations,:class_name => "UserDoctor", :foreign_key => "doctor_id"

  def patients
   return patient_consultations
  end

end

