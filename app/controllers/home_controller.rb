class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[home show programs edit update]
  before_action :set_user, only: %i[edit show update]

  def index
  end

  def home
    # quotes = ['Rise and grind, ', 'Own your day, ', "Let's get those reps in, ", 'Time to flex those muscles, ', "Let's hit those gains, ", 'Time to dominate the gym, ']
    # @quote = quotes.sample
  end

  def edit 
  end

  def programs 
  end

  def show
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def create_default_workout_and_redirect
    unless current_user.workouts.exists?(name: 'Full Body Workout')
      workout = current_user.workouts.create!(name: 'Full Body Workout')
      workout.exercises.create!([
        { name: 'close-grip push-up (on knees)', body_part: 'upper arms', url: 'https://v2.exercisedb.io/image/tQpjxWErzXPHxE' },
        { name: 'decline push-up', body_part: 'chest', url: 'https://v2.exercisedb.io/image/JRnAyD6OWs8YIn' },
        { name: 'bench pull-ups', body_part: 'back', url: 'https://v2.exercisedb.io/image/3EkedQAnI4XCqK' },
        { name: 'bodyweight squatting row', body_part: 'back', url: 'https://v2.exercisedb.io/image/hRrjHsiS6ossUJ' },
        { name: 'forward jump', body_part: 'upper legs', url: 'https://v2.exercisedb.io/image/wvEBnfbLWMekvu' },
        { name: 'bodyweight drop jump squat', body_part: 'upper legs', url: 'https://v2.exercisedb.io/image/XepqIICNKiRJ8l' },
        { name: 'alternate heel touchers', body_part: 'waist', url: 'https://v2.exercisedb.io/image/Y99VpeCGG19urP' },
        { name: 'back and forth step', body_part: 'cardio', url: 'https://v2.exercisedb.io/image/JW7-fsrsAxNVAY' }
      ])
    end
    redirect_to workouts_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:weight, :height, :first_name, :last_name, :email)
  end
end
