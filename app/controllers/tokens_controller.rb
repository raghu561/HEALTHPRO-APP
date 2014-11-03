class TokensController  < ApplicationController 
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def get_user_details
    total_count = 0
    user = User.find(params[:id])
    if user.role == 'Doctor'
      pat_ids = user.patients.collect{|x| x.user_id}
      users = User.where("id in (?)",pat_ids)
      users.each do |x|
        puts "============================unread_count #{x.unread_count}"
        if x.unread_count
           total_count = total_count + x.unread_count
        end
      end
    end
    puts "============================ #{total_count}"
    render :status => 200, :json=>{:data => user.to_json, :total_count => total_count.to_json}
  end

  def create_user
    user = User.new(params[:user])
    if user.role == 'Doctor'
      geocoder = Geocoder.search(user.zip)
      if geocoder && geocoder[0] && geocoder[0].geometry
        user.lattitude = geocoder[0].geometry["location"]["lat"]
        user.longitude =  geocoder[0].geometry["location"]["lng"]
      end
    end
    if user.role == 'Patient'
      geocoder = Geocoder.search(user.zip)
       if geocoder && geocoder[0] && geocoder[0].geometry
        user.lattitude = geocoder[0].geometry["location"]["lat"]
        user.longitude =  geocoder[0].geometry["location"]["lng"]
      end
    end
    if !user.save
      render json: user.errors, status: :unprocessable_entity
    else
      user.ensure_authentication_token
      user.save!
      render :status => 200, :json=>{:token=>user.authentication_token, :message=>"Registered Successfull"}
    end

  end

  def create
    
    email = params[:user][:email]
    password = params[:user][:password]
    
    if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json"}
        return
    end
    
    if email.nil? or password.nil? 
      render :status=>400, :json=>{:message=>"The request must contain the user email and password."}
      return
    end
    
    @user = User.find_by_email(email.downcase)
    
    if @user.nil?
      logger.info("User #{email} failed signin, user cannot be found.")
      render :status=>401, :json=>{:message=>"Invalid email or passoword."}
      return
    end
    
    @user.ensure_authentication_token
    @user.save!
    
    if not @user.valid_password?(password) 
      logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:message=>"Invalid email or passoword."} 
    else
#      headers[:content_disposition] = "attachment; filename=\"filename.ext\""
      render :status => 200, :json=>{:token=>@user.authentication_token, :user_id => @user.id ,:message=>"Signin Successfull"}
    end
  end
  
  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Token not found.")
      render :status=>404, :json=>{:message=>"Invalid token."}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end  

  def fb_authentication

  end
end  

