class SignupSerializer < ActiveModel::Serializer
  attributes :id, :camper_id, :activity_id, :time, :name, :difficulty
  belongs_to :activity
  belongs_to :camper

  def name
    self.object.activity.name
  end
  def difficulty
    self.object.activity.difficulty
  end
end
