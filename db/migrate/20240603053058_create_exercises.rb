class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :body_part
      t.string :url
      t.text :instructions

      t.timestamps
    end
  end
end
