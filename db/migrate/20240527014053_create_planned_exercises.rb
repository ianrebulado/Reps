class CreatePlannedExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :planned_exercises do |t|
      t.string :name
      t.string :target_muscle
      t.integer :sets
      t.integer :reps
      t.text :notes

      t.timestamps
    end
  end
end
