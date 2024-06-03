class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts, dependent: :destroy
  has_many :exercises, through: :workouts

  def age
    now = Time.now.localtime.to_date
    dob = date_of_birth
    age = now.year - dob.year
    age -= 1 if now.month < dob.month || (now.month == dob.month && now.day < dob.day)
    age
  end

  def name
    "#{first_name} #{last_name}"
  end
  
end
