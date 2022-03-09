# == Schema Information
#
# Table name: friends
#
#  id            :integer          not null, primary key
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  influencer_id :integer
#  owner_id      :integer
#
class Friend < ApplicationRecord

  belongs_to(:influencer, { :required => true, :class_name => "User", :foreign_key => "influencer_id", :counter_cache => true })

  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id" })
  
end
