class Workout < ApplicationRecord
  belongs_to :user
  has_many :planned_exercises
end
