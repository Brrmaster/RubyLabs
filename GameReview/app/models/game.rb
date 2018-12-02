class Game < ApplicationRecord
	belongs_to :user
	has_many :reviews


	#protects against sql stuff????
	sanitize_sql_for_conditions :title
	sanitize_sql_for_conditions :genre
	sanitize_sql_for_conditions :developer
	sanitize_sql_for_conditions :description

	#basic validation for inputs
	validates_length_of :title, :in => 1..50
	validates_length_of :genre, :in => 1..50
	validates_length_of :developer, :in => 1..50
	validates_length_of :description, :in => 5..1000

	validates_presence_of :game_img



	has_attached_file :game_img, styles: { game_index: "250x300>", game_show: "325x375>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :game_img, content_type:  /\Aimage\/.*\z/

  	



  	def self.search(search)
  		where("title LIKE ? OR genre LIKE ? OR developer LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  	end
end