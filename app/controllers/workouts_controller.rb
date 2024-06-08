class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: [:show, :destroy]

  def index
    @workouts = current_user.workouts
    @exercises = current_user.exercises
  end

  def show
    @workout = Workout.find(params[:id])
  end

  def new
    @workout = current_user.workouts.new
  end

  def create
    @workout = current_user.workouts.new(workout_params)
    if @workout.save!
      redirect_to new_workout_exercise_path(@workout)
    else
      render :new
    end
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.exercises.destroy_all
    @workout.destroy
    redirect_to workouts_path, notice: "Workout and associated exercises were successfully deleted."
  end
  

  private

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :date)
    rescue ActiveRecord::RecordNotFound
    redirect_to programs_path
  end
end