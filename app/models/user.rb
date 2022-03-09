# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  home_location   :string
#  last_name       :string
#  password_digest :string
#  phone           :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password


 has_many(:locations, { :class_name => "Location", :foreign_key => "owner_id", :dependent => :destroy })

 has_many(:friends, { :class_name => "Friend", :foreign_key => "influencer_id", :dependent => :destroy })

 has_many(:followed, { :class_name => "Friend", :foreign_key => "owner_id", :dependent => :destroy })


end
