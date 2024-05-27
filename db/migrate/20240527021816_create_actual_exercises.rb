class CreateActualExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :actual_exercises do |t|
      t.references :planned_exercise, null: false, foreign_key: true
      t.integer :sets
      t.integer :reps
      t.string :status

      t.timestamps
    end
  end
end
