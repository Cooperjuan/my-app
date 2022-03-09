desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do

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

  bool = ["accepted", "pending", "rejected"]



end
