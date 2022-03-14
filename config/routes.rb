Rails.application.routes.draw do

  # Routes for the Friend resource:

  # CREATE
  post("/add_friend", { :controller => "friends", :action => "create" })
          
  # READ
  get("/friends", { :controller => "friends", :action => "index" })

  get("/friends/requests", { :controller => "friends", :action => "requests" })
  
  get("/friends/:path_id", { :controller => "friends", :action => "show_location_to_friends" })
  
  # UPDATE

  post("/reject", { :controller => "friends", :action => "reject" })

  post("/accept", { :controller => "friends", :action => "accept" })


  post("/modify_friend/:path_id", { :controller => "friends", :action => "update" })
  
  # DELETE
  post("/delete_friend", { :controller => "friends", :action => "destroy" })

  #------------------------------

  # Routes for the Location resource:

  # CREATE
  post("/insert_location", { :controller => "locations", :action => "create" })
          
  # READ
  get("/locations", { :controller => "locations", :action => "index" })
  
  get("/locations/:path_id", { :controller => "locations", :action => "show" })
  
  # UPDATE
  
  post("/modify_location/:path_id", { :controller => "locations", :action => "update" })
  
  # DELETE
  get("/delete_location/:path_id", { :controller => "locations", :action => "destroy" })

  #------------------------------

  get("/", { :controller => "application", :action => "homepage" })

  get("/address_form", { :controller => "locations", :action => "address_form" })

  get("/show_maps", { :controller => "locations", :action => "show_map" })

  get("/send_message", { :controller => "locations", :action => "send_message" })
 

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
