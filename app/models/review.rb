class Review < ApplicationRecord
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true

  before_save do
    self.total_score = (self.service_score + self.serving_score + self.girl_score + self.ambience_score + self.again_score)
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.sender_type self.sender_type
      json.sender_id self.sender_id
      json.receiver_type self.receiver_type
      json.receiver_id self.receiver_id
      json.service_score self.service_score
      json.girl_score self.girl_score
      json.ambience_score self.ambience_score
      json.again_score self.again_score
      json.comment self.comment
      json.is_displayed self.is_displayed
      json.sender self.sender.to_jbuilder
      json.receiver self.receiver.to_jbuilder
    end
  end

  def self.to_jbuilders(reviews)
    Jbuilder.new do |json|
      json.array! reviews do |review|
        json.id review.id
        json.type review.type
        json.sender_type review.sender_type
        json.sender_id review.sender_id
        json.receiver_type review.receiver_type
        json.receiver_id review.receiver_id
        json.service_score review.service_score
        json.girl_score review.girl_score
        json.ambience_score review.ambience_score
        json.again_score review.again_score
        json.comment review.comment
        json.is_displayed review.is_displayed
        json.sender review.sender.to_jbuilder
        json.receiver review.receiver.to_jbuilder
      end
    end
  end

end
