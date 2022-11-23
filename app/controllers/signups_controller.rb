class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_notfound_method
    
    def index
        render json: Signup.all
    end

    # def show
    #     signup = find_signup
    #     render json: signup
    # end

    def create
        signup = Signup.create!(signup_params)
        render json: signup, include: ["activity"], status: :created
    end

    def update
        signup = find_signup
        signup.update!(signup_params)
        render json: signup, status: :created
        # , include: ["activity.id","activity.name","activity.difficulty"]
        # render json: {id: signup[:id],camper_id: signup[:camper_id], name:signup[:activity_id], activity: signup[:activity]}, status: :accepted
    end

    private
    def find_signup
        Signup.find_by(id: params[:id])
    end

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def record_notfound_method e
        byebug
      render json: {errors:  e.record.errors}, status: :not_found
    end

    def render_unprocessable_entity(exception)
        render json: {errors:  [exception.record.errors]}, status: :unprocessable_entity
    end
end
