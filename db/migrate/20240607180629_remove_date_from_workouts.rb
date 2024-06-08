class RemoveDateFromWorkouts < ActiveRecord::Migration[7.1]
  def change
    remove_column :workouts, :date, :date
  end
end
