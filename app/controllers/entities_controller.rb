class EntitiesController < ApplicationController
    before_action :set_entity, only: [:show]
  
    def index
      @entities = Entity.all
    end
  
    def new
      @entity = Entity.new
    end
  
    def create
      @entity = Entity.new(entity_params)
      if @entity.save
        redirect_to @entity, notice: 'Entity was successfully created.'
      else
        render :new
      end
    end
  
    def show
    end
  
    private
  
    def set_entity
      @entity = Entity.find(params[:id])
    end
  
    def entity_params
      params.require(:entity).permit(:full_name, :profile_image, :cover_photo)
    end
  end
  