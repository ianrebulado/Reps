class DropPlannedExercises < ActiveRecord::Migration[7.1]
  def up
    drop_table :actual_exercises
    drop_table :planned_exercises
  end
end
