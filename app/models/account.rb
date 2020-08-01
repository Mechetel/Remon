class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :communities

  validates_presence_of :first_name, :last_name, :username

  def full_name
    "#{first_name} #{last_name}"
  end
end
