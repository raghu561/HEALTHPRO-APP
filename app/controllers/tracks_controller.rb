class TracksController < ApplicationController
  def create
    track = Track.new(params[:track])
    from_address = params[:from_address]
    to_address = params[:to_address]
    from_geocoder = Geocoder.search("#{from_address[0]},#{from_address[1]}")
    to_geocoder = Geocoder.search("#{to_address[0]},#{to_address[1]}")
    puts "=========================== #{from_geocoder}"
    puts "=========================== #{to_geocoder}"
    track.from_address = from_geocoder[0].formatted_address
    track.to_address = to_geocoder[0].formatted_address
    track.read_flag = 0
    
    if track.save
      puts "=========================== i am in track saves"
      user = track.user
      if user.unread_count
        puts "=========================== i am in track second condition"
        user.unread_count = user.unread_count  + 1
      else
       puts "=========================== i am in track third condition"
       user.unread_count =  1
      end
      
      user.save
      puts "=========================== final user object #{user.inspect}"
      render :status => 200, :json=>{:message=>"Track saved Successfully"}
    else
      render json: track.errors, status: :unprocessable_entity
    end
  end

  def index
    user = User.find(params[:user_id])
    if user.role != 'Patient'
      pat_ids = user.patients.collect{|x| x.user_id}
      tracks = Track.where("user_id in (?)",pat_ids)
      users = User.where("id in (?)",pat_ids)
      total_count = users.all.sum(:unread_count);
    else
      tracks = Track.where("user_id in (?)",user.id)
      users = User.where("id in (?)",[user.id])
    end
    
    render :json => {:data => tracks.to_json,:users => users.to_json}
  end

  def show
    track = Track.find(params[:id])
    if track.read_flag == 0
      track.read_flag = 1
      track.save
      user = track.user
      if user.unread_count > 0
        user.unread_count = user.unread_count - 1
        user.save
      end
    end
    render :json => {:data => track.to_json}
  end
end
