# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

#Direct Associations
  has_many(:photos, { :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:comments, { :class_name => "Comment", :foreign_key => "author_id", :dependent => :destroy })
  has_many(:likes, { :class_name => "Like", :foreign_key => "fan_id", :dependent => :destroy })
  has_many(:received_requests, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy })
  has_many(:follow_requests, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })

  #Inirect Associations
  has_many(:followings, { :through => :follow_requests, :source => :recipient })
  has_many(:followers, { :through => :received_requests, :source => :sender })
  has_many(:liked_photos, { :through => :likes, :source => :photo })
  has_many(:commented_photos, { :through => :comments, :source => :photo })


end
