class Camper < ApplicationRecord
 validates :name, presence: true
 validate :age_range
 has_many :signups
 has_many :activities, through: :signups

 def age_range
    if !(age< 19 && age >7)
        errors.add(:age, "must be between 18 and 8")
    end
 end
end
