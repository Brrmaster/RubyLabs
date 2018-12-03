class User < ApplicationRecord
	has_many :restaurants
	has_many :reviews

	validates_length_of :email, :in => 4..50
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
