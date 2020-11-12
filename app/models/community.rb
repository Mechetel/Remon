 class Community < ApplicationRecord
  has_many :posts
  belongs_to :account
  

  validates_presence_of :url, :name, :rules
 end
