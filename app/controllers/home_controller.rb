class HomeController < ApplicationController
  def index

  end

  def patients
   patients = User.where(role: "Patient").select("name,phone,city,id,emergency_contact_phone,emergency_contact_name")
   render :json => {:data => patients.to_json}
  end

  def doctors
    patients = User.where(role: "Doctor").select("name,phone,city,id,emergency_contact_phone,emergency_contact_name")
    consult_ids = UserDoctor.where(user_id: params[:user_id]).select("doctor_id")
    render :json => {:data => patients.to_json,:consult_ids => consult_ids.to_json}
  end

  def geo_locations
    user = User.find(params[:id])
    users = []
    if user.role == "Doctor"
      users = User.where("role='Patient' and lattitude != '' and longitude != '' ").select("lattitude,longitude")
    end
    if user.role == "Patient"
      users = User.where("role='Doctor' and lattitude != '' and longitude != '' ").select("lattitude,longitude")
    end
    render :status=>200, :json=>{:data => users.to_json}
  end

  def consult_doctor
   user_doctor = UserDoctor.new(user_id: params[:user_id],doctor_id: params[:doctor_id])
   user_doctor.save!
   render :status=>200, :nothing => true
  end
end
