class FriendsController < ApplicationController
  def index
    matching_followed = Friend.where({ :owner_id => session.fetch(:user_id) }).where({ :status => "accepted" })

    @list_of_followed = matching_followed.order({ :created_at => :desc })

    pending_friends = Friend.where({ :influencer_id => session.fetch(:user_id) }).where({ :status => "pending" })

    @list_of_requests = pending_friends.order({ :created_at => :desc })



    matching_followers = Friend.where({ :influencer_id => session.fetch(:user_id) }).where({ :status => "approved" })

    @list_of_followers = matching_followers.order({ :created_at => :desc })

    render({ :template => "friends/index.html.erb" })
  end

  def show_location_to_friends
    the_id = params.fetch("path_id")

    matching_friends = Friend.where({ :id => the_id })

    @the_friend = matching_friends.at(0)

    friend_in_location = Location.where({ :owner_id => the_id }).at(0)

    @friend_location = friend_in_location.address


    @gmap_key = ENV.fetch("GMAPS_KEY")
       
     @maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @friend_location + "&key=" + @gmap_key
 
     @raw_json_string = open(@maps_url).read
 
     @parsed_json = JSON.parse(@raw_json_string)
 
     @results_array = @parsed_json.fetch("results")
 
     @first_result = @results_array.at(0)
     
     @geometry_hash = @first_result.fetch("geometry")
 
     @location_hash = @geometry_hash.fetch("location")
 
     @latitude = @location_hash.fetch("lat")
     @longitude = @location_hash.fetch("lng")
  
     @address_components_hash = @first_result.fetch("formatted_address")

    render({ :template => "friends/show_location_to_friends.html.erb" })
  end


  def create
    the_friend = Friend.new
    the_friend.owner_id = params.fetch("query_user_id")
    influencer = User.where({ :username => params.fetch("username") }).at(0)

      if influencer == nil

      redirect_to("/friends", { :alert => "Request failed" })

      else

      the_friend.influencer_id = influencer.id
  
      the_friend.status = "pending"
  
  
      if the_friend.valid?
        the_friend.save
        redirect_to("/friends", { :notice => "Request sent succesfully" })
      else
        redirect_to("/friends", { :alert => "Request failed" })
      end
    end   
  end




  def accept

    influencer_id = params.fetch("influencer_id")
    follower_id = params.fetch("follower_id")
    #@follower_username = follower.username
    the_request = Friend.where({ :owner_id => follower_id }).where({ :influencer_id => influencer_id }).at(0)

    the_request.status = "approved"

    the_request.save
      redirect_to("/friends", { :notice =>  " is now following you"} )

  end

  def reject

    follower_id = params.fetch("follower_id")

    influencer_id = params.fetch("influencer_id")
    follower_id = params.fetch("follower_id") 
    #@follower_username = follower.username
    the_request = Friend.where({ :owner_id => follower_id }).where({ :influencer_id => influencer_id }).at(0)

    
    the_request.status = "rejected"

    the_request.save
      redirect_to("/friends", { :notice =>  " follow request has been rejected"} )

  end

  def update
    the_id = params.fetch("path_id")
    the_friend = Friend.where({ :id => the_id }).at(0)

    the_friend.owner_id = params.fetch("query_owner_id")
    the_friend.influencer_id = params.fetch("query_influencer_id")
    the_friend.status = params.fetch("query_status")

    if the_friend.valid?
      the_friend.save
      redirect_to("/friends/#{the_friend.id}", { :notice => "Friend updated successfully."} )
    else
      redirect_to("/friends/#{the_friend.id}", { :alert => "Friend failed to update successfully." })
    end
  end



  def destroy

    influencer_id = params.fetch("influencer_id")
    follower_id = params.fetch("follower_id")
    
    friendship = Friend.where({ :owner_id => follower_id }).where({ :influencer_id => influencer_id }).at(0)

    friendship.destroy

    redirect_to("/friends", { :notice => "Friend deleted successfully."} )
  end


  def requests

    @user_id = session.fetch(:user_id)

    @list_of_requests = Friend.where({ :influencer_id => @user_id }).all.order({ :created_at => :desc })

    render({ :template => "friends/request.html.erb" })
  end


























end
