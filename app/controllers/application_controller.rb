class ApplicationController < ActionController::Base
  #before_action(:load_current_user)
  
  def homepage
    render({ :template => "misc_templates/home"})
  end


  def address_form
    render({ :template => "misc_templates/address_form"})
  end  



  
  # Uncomment this if you want to force users to sign in before any other actions
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end



  def show_map
    # Parameters: {"user_street_address"=>"Merchandise Mart, Chicago"}

    @street_address = params.fetch("user_input")

    @maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address + "&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

    @raw_json_string = open(@maps_url).read

    @parsed_json = JSON.parse(@raw_json_string)

    @results_array = @parsed_json.fetch("results")

    @first_result = @results_array.at(0)
    
    @geometry_hash = @first_result.fetch("geometry")

    @location_hash = @geometry_hash.fetch("location")

    @latitude = @location_hash.fetch("lat")
    @longitude = @location_hash.fetch("lng")

    render({ :template => "misc_templates/show_maps"})


  end












end
