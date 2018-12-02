class Restaurant < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews

	sanitize_sql_for_conditions :title
	sanitize_sql_for_conditions :description
	sanitize_sql_for_conditions :location
	sanitize_sql_for_conditions :category_id

	validates_length_of :title, :in => 5..50
	validates_length_of :description, :in => 5..1000
	validates_length_of :location, :in => 5..50
	validates_presence_of :category_id

	has_attached_file :restaurant_img, styles: { restaurant_index: "250x300>", restaurant_show: "325x375>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :restaurant_img, content_type:  /\Aimage\/.*\z/

  	validates_presence_of :restaurant_img, :title, :description, :location
end
