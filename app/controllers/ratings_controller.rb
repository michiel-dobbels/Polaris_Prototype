class RatingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_entity
  
    def create
      @rating = @entity.ratings.find_or_initialize_by(user: current_user)
      @rating.stars = rating_params[:stars]
  
      if @rating.save
        redirect_to entity_path(@entity), notice: "Rating submitted!"
      else
        redirect_to entity_path(@entity), alert: "There was a problem submitting your rating."
      end
    end

    def set_entity
        @entity = Entity.find(params[:entity_id])
    end

    def rating_params
        params.require(:rating).permit(:stars)
    end
  
    private
  
    
  end
  