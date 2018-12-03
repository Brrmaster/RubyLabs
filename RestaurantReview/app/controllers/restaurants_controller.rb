class RestaurantsController < ApplicationController
	before_action :find_restaurant, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	before_action :check_user, only: [:edit, :update, :destroy]
	
	def index
		if params[:category].blank?
			@restaurants = Restaurant.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@restaurants = Restaurant.where(:category_id => @category_id).order("created_at DESC")
		end
	end

	def show
		if @restaurant.reviews.blank?
			@average_review = 0
		else
			@average_review = @restaurant.reviews.average(:rating).round(2)
		end
	end
	
	def new
		@restaurant = current_user.restaurants.build
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def create
		@restaurant = current_user.restaurants.build(restaurant_params)
		@restaurant.category_id = params[:category_id]


		if @restaurant.save
			redirect_to root_path
		else
			#@restaurant = current_user.restaurants.build
			@categories = Category.all.map{ |c| [c.name, c.id] }
			render 'new'
		end
	end

	def edit
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def update
		@restaurant.category_id = params[:category_id]
		if @restaurant.update(restaurant_params)
			redirect_to restaurant_path(@restaurant)
		else
			render 'edit'
		end
	end 

	def destroy
		@restaurant.destroy
		redirect_to root_path
	end

	private

		def restaurant_params
			params.require(:restaurant).permit(:title, :description, :location, :category_id, :restaurant_img)
		end

		def find_restaurant
			@restaurant = Restaurant.find(params[:id])
		end

		def check_user
			find_restaurant
			if @restaurant.user_id != current_user.id
				flash[:notice] = "I know what you're trying to do Enke... I'm on to you!"
				redirect_to restaurant_path(@restaurant)
			end
		end


end
