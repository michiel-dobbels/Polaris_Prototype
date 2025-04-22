class RatingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_entity
  
    def create
      @rating = @entity.ratings.find_or_initialize_by(user: current_user)
      @rating.stars = rating_params[:stars]
      @rating.review = rating_params[:review] # 👈 ADD THIS
    
      respond_to do |format|
        if @rating.save
          format.html { redirect_to entity_path(@entity), notice: 'Rating submitted!' }
        else
          format.html { redirect_to entity_path(@entity), alert: 'There was a problem submitting your rating.' }
        end
      end
    end
    
    def update
      @rating = @entity.ratings.find_or_initialize_by(user: current_user)
      @rating.stars = rating_params[:stars]
      @rating.review = rating_params[:review] # 👈 ADD THIS
    
      respond_to do |format|
        if @rating.save
          format.html { redirect_to entity_path(@entity), notice: 'Rating updated!' }
        else
          format.html { redirect_to entity_path(@entity), alert: 'There was a problem updating your rating.' }
        end
      end
    end
    

    
    
  
    private
  
    def set_entity
      @entity = Entity.find(params[:entity_id])
    end
  
    def rating_params
      params.require(:rating).permit(:stars, :review)
    end
  end
  