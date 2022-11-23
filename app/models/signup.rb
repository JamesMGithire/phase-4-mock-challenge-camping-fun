class Signup < ApplicationRecord
    validate :time_range 
    belongs_to :activity
    belongs_to :camper

    def time_range
        if time
            if !(time.to_i < 24 && time.to_i > -1)
                errors.add(:time, "must be between 0 and 23")
            end
        else
            errors.add(:time, "must be between 0 and 23")
        end
    end

end
