class GamesController < ApplicationController
	before_action :find_game, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	before_action :check_user, only: [:edit, :update, :destroy]

	def index
		if params[:search]
			@games = Game.search(params[:search]).order("created_at DESC")
		else
			@games = Game.all.order("created_at DESC")
		end
	end

	def new
		@game = current_user.games.build
	end

	def create
		@game = current_user.games.build(game_params)

		if @game.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		if @game.reviews.blank?
			@average_review = 0
		else
			@average_review = @game.reviews.average(:rating).round(2)
		end
	end

	def edit

	end

	def update
		if @game.update(game_params)
			redirect_to game_path(@game)
		else
			render 'edit'
		end
	end

	def destroy
		@game.destroy
		redirect_to root_path
	end

	private

		def game_params
			params.require(:game).permit(:title, :description, :developer, :genre, :game_img)
		end

		def find_game
			@game = Game.find(params[:id])
		end

		def check_user
			find_game
			if @game.user_id != current_user.id
				flash[:notice] = "I know what you're trying to do Enke... I'm on to you!"
				redirect_to game_path(@game)
			end
		end

end
