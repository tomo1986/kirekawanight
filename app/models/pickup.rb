class Pickup < ApplicationRecord

  belongs_to :subject, polymorphic: true


  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.subject_type self.subject_type
      json.subject_id self.subject_id
      json.price self.price
      json.start_at self.start_at
      json.end_at self.end_at
      json.number_place self.number_place
      json.subject self.subject
    end
  end

  def self.to_jbuilders(pickups)
    Jbuilder.new do |json|
      json.array! pickups do |pickup|
        json.id pickup.id
        json.type pickup.type
        json.subject_type pickup.subject_type
        json.subject_id pickup.subject_id
        json.price pickup.price
        json.start_at pickup.start_at
        json.end_at pickup.end_at
        json.number_place pickup.number_place
        json.subject pickup.subject
      end
    end
  end

end
