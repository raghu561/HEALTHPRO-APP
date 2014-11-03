class UserDoctorsController < ApplicationController
  # GET /user_doctors
  # GET /user_doctors.json
  def index
    @user_doctors = UserDoctor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_doctors }
    end
  end

  # GET /user_doctors/1
  # GET /user_doctors/1.json
  def show
    @user_doctor = UserDoctor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_doctor }
    end
  end

  # GET /user_doctors/new
  # GET /user_doctors/new.json
  def new
    @user_doctor = UserDoctor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_doctor }
    end
  end

  # GET /user_doctors/1/edit
  def edit
    @user_doctor = UserDoctor.find(params[:id])
  end

  # POST /user_doctors
  # POST /user_doctors.json
  def create
    @user_doctor = UserDoctor.new(params[:user_doctor])

    respond_to do |format|
      if @user_doctor.save
        format.html { redirect_to @user_doctor, notice: 'User doctor was successfully created.' }
        format.json { render json: @user_doctor, status: :created, location: @user_doctor }
      else
        format.html { render action: "new" }
        format.json { render json: @user_doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_doctors/1
  # PUT /user_doctors/1.json
  def update
    @user_doctor = UserDoctor.find(params[:id])

    respond_to do |format|
      if @user_doctor.update_attributes(params[:user_doctor])
        format.html { redirect_to @user_doctor, notice: 'User doctor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_doctors/1
  # DELETE /user_doctors/1.json
  def destroy
    @user_doctor = UserDoctor.find(params[:id])
    @user_doctor.destroy

    respond_to do |format|
      format.html { redirect_to user_doctors_url }
      format.json { head :no_content }
    end
  end
end
