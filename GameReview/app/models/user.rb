class User < ApplicationRecord
	has_many :games
	has_many :reviews

	validates_length_of :email, :in => 4..100
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
