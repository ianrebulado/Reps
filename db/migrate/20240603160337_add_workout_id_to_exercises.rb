class AddWorkoutIdToExercises < ActiveRecord::Migration[7.1]
  def change
    add_reference :exercises, :workout, null: false, foreign_key: true
  end
end
