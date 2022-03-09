# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  address    :text
#  map_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#
class Location < ApplicationRecord

  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id" })
  
end
