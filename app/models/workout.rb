class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercises
  accepts_nested_attributes_for :exercises
  
  def self.for_today(user)
    where(user_id: user.id)
      .where("EXTRACT(DOW FROM created_at) = ?", Time.current.strftime("%w"))
  end
end
