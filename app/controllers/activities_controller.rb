class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_notfound_method
    # rescue_from ActiveRecord::ForbiddenAttributesError, with: :render_unprocessable_entity
    def index
      activities = Activity.all
      render json: activities
    end

    # def show
    #   activity = Activity.find(params[:id])
    #   render json: activity
    # end

    def create
      activity = Activity.create!(activity_params)
      render json: activity, status: :created
    end

    def destroy
      activity = find_activity
      if activity
        activity.destroy!
        render status: :no_content
      else
        render json: {error: "Activity not found" }, status: :not_found
      end
    end
    
    private
    def find_activity
        activity = Activity.find_by(id: params[:id])
    end

    def activity_params
        params.permit(:name, :difficulty)
    end

    def record_notfound_method
      render json: {error: "Activity not found" }, status: :not_found
    end

    def render_unprocessable_entity(exception)
        render json: {errors:  exception.record.errors}, status: :unprocessable_entity
    end
end
