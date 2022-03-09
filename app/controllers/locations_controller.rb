class LocationsController < ApplicationController


  require "twilio-ruby"

  def address_form




    render({ :template => "misc_templates/address_form"})
  end  




  def show_map
 
    @gmap_key = ENV.fetch("GMAPS_KEY")
    
    @street_address = params.fetch("user_input")
 
     @maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address + "&key=" + @gmap_key
 
     @raw_json_string = open(@maps_url).read
 
     @parsed_json = JSON.parse(@raw_json_string)
 
     @results_array = @parsed_json.fetch("results")
 
     @first_result = @results_array.at(0)
     
     @geometry_hash = @first_result.fetch("geometry")
 
     @location_hash = @geometry_hash.fetch("location")
 
     @latitude = @location_hash.fetch("lat")
     @longitude = @location_hash.fetch("lng")
  
     @address_components_hash = @first_result.fetch("formatted_address")
 
     #@route = @address_components_hash.fetch("route")
       render({ :template => "misc_templates/show_maps"})
 
    end



    def show_map_to_friends
 
      @gmap_key = ENV.fetch("GMAPS_KEY")
      
      @street_address = params.fetch("user_input")
   
       @maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address + "&key=" + @gmap_key
   
       @raw_json_string = open(@maps_url).read
   
       @parsed_json = JSON.parse(@raw_json_string)
   
       @results_array = @parsed_json.fetch("results")
   
       @first_result = @results_array.at(0)
       
       @geometry_hash = @first_result.fetch("geometry")
   
       @location_hash = @geometry_hash.fetch("location")
   
       @latitude = @location_hash.fetch("lat")
       @longitude = @location_hash.fetch("lng")
    
       @address_components_hash = @first_result.fetch("formatted_address")
   
       #@route = @address_components_hash.fetch("route")
         render({ :template => "misc_templates/show_maps_to_friends"})
   
      end
 
 
   def send_message
  
     @message = params.fetch("user_input")
 
     @user_id = params.fetch("user_id")
 
      
     twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
     twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
     twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")
 
 
    friends = Friend.where({ :influencer_id => @user_id })

    friends.each do |a_friend|

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
 
 
     sms_parameters = {
   :from => twilio_sending_number,
   :to => "+13126871442",
   :body => @message
   }
 
 
   twilio_client.api.account.messages.create(sms_parameters)


    end
 
 render({ :template => "misc_templates/send_message"})
 
   end
 


  def create
    the_location = Location.new
    the_location.map_url = params.fetch("query_map_url")
    the_location.address = params.fetch("query_address")
    the_location.owner_id = params.fetch("query_owner_id")

    the_location.save
      redirect_to("/locations", { :notice => "Location created successfully." })

    end
 


  def update
    the_id = params.fetch("path_id")
    the_location = Location.where({ :id => the_id }).at(0)

    the_location.map_url = params.fetch("query_map_url")
    the_location.address = params.fetch("query_address")
    the_location.owner_id = params.fetch("query_owner_id")

    if the_location.valid?
      the_location.save
      redirect_to("/locations/#{the_location.id}", { :notice => "Location updated successfully."} )
    else
      redirect_to("/locations/#{the_location.id}", { :alert => "Location failed to update successfully." })
    end
  end









  def index
    matching_locations = Location.all

    @list_of_locations = matching_locations.order({ :created_at => :desc })

    render({ :template => "locations/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_locations = Location.where({ :id => the_id })

    @the_location = matching_locations.at(0)

    render({ :template => "locations/show.html.erb" })
  end


  def destroy
    the_id = params.fetch("path_id")
    the_location = Location.where({ :id => the_id }).at(0)

    the_location.destroy

    redirect_to("/locations", { :notice => "Location deleted successfully."} )
  end
end
