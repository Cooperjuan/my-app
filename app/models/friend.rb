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


  
  validates_uniqueness_of :owner_id, scope: :influencer_id


end
