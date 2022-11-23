class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_notfound_method
    # rescue_from ActiveModel::ForbiddenAttributesError, with: :render_unprocessable_entity
    
    def index
        render json: Camper.all, each_serializer: MinimalCamperSerializer
    end
    
    def show
        camper = find_camper
      if camper
        render json: camper, except: ["signups"]
      else
      render json: {error: "Camper not found" }, status: :not_found
      end
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private
    def find_camper
        camper = Camper.find_by(id: params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def record_notfound_method
      render json: {error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity(exception)
        render json: {errors:  [exception.record.errors]}, status: :unprocessable_entity
    end
end
