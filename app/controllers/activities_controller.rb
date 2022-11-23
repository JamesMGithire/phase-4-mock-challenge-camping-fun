class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_notfound_method

    def index
      activities = Activity.all
      render json: activities
    end

    def create
      activity = Activity.create!(activity_params)
      render json: activity, status: :created
    end

    def destroy
      activity = find_activity
        activity.destroy!
        render status: :no_content
    end
    
    private
    def find_activity
        activity = Activity.find_by!(id: params[:id])
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
