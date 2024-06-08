class ExercisesController < ApplicationController
  before_action :set_workout

  def new
    @exercise = @workout.exercises.new

    @body_parts = client.get_body_parts # fetch bp
    @body_part = params[:body_part] # bp param

    if @body_part.present?
      edited_body_part = @body_part.gsub(' ', '%20') if @body_part.include?(' ')
      body_part = (edited_body_part || @body_part).downcase
      @exercises = client.get_exercises(body_part)
    end
  end

  def create
    puts "#{params.inspect}"
    @exercise = @workout.exercises.new(exercise_params)
    if @exercise.save
      flash[:notice] = "Exercise was successfully added."
      render json: { success: true, flash: flash }
    else
      render :new
    end
  end

  def destroy
    @exercise = @workout.exercises.find(params[:id])
    @exercise.destroy
    redirect_to @workout, notice: 'Exercise was successfully removed.'
  end

  private

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :url, :body_part)
  end

  def client
    @client ||= ExerciseApi::V1::Client.new
  end
end
