class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [:cancel ]
#  before_filter :require_admin, :only => [:create, :new ]
  def new
    resource = build_resource({})
    respond_with resource
  end

  def create
    build_resource
    #resource.active = true
    respond_to do |format|
      if resource.save
        format.json { render json: @user, status: :created}
      else
        clean_up_passwords @user
        puts "===========#{@user.errors.inspect}"
        format.json { render json: @user, status: :created}
       # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end
end
