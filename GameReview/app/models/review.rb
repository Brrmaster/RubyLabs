class Review < ApplicationRecord
	belongs_to :game
	belongs_to :user


	validates_presence_of :comment
	validates_presence_of :rating

	sanitize_sql_for_conditions :comment

	validates_length_of :comment, :in => 5..150

	profanity_filter :comment

end
