desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do



  User.destroy_all
  Location.destroy_all
  Friend.destroy_all
 
  name = ["Juan"]
  bool = [true, false]
  
   50.times do |count|
      user = User.new
      user.username = name.sample + rand(10).to_s
      user.first_name = "Juan"
      user.last_name = "Cooper"
      user.phone = "+13126871442"
      user.home_location = "harper center"
      user.email = name.sample + rand(10).to_s
      user.password = "my_password"
      user.save

p user.errors.full_messages

   end


#  id            :integer          not null, primary key
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  influencer_id :integer
#  owner_id      :integer

  bool = ["accepted", "pending", "rejected"]

  users = User.all

  100.times do 
    fr = Friend.new
    fr.status = bool.sample
    fr.influencer_id = users.sample.id 
    fr.owner_id = users.sample.id 
    fr.save

  end


  #  id         :integer          not null, primary key
#  address    :text
#  map_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
  
bool = ["Harper Center Booth", "Willis Tower", "The White House"]

users = User.all

@gmap_key = ENV.fetch("GMAPS_KEY")
      
100.times do 
  loc = Location.new
  loc.address = bool.sample
  loc.map_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + bool.sample + "&key=" + @gmap_key
  loc.owner_id = users.sample.id 
  loc.save

end


end
