class Contact < ApplicationRecord
  belongs_to :subject, polymorphic: true
  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.subject_type self.subject_type
      json.subject_id self.subject_id
      json.name self.name
      json.email self.email
      json.sns_line self.sns_line
      json.sns_zalo self.sns_zalo
      json.sns_wechat self.sns_wechat
      json.message self.message
      json.created_at self.created_at
      json.return_way self.return_way
      json.subject self.subject
    end
  end

  def self.to_jbuilders(contacts)
    Jbuilder.new do |json|
      json.array! contacts do |contact|
        json.id contact.id
        json.type contact.type
        json.subject_type contact.subject_type
        json.subject_id contact.subject_id
        json.name contact.name
        json.email contact.email
        json.sns_line contact.sns_line
        json.sns_zalo contact.sns_zalo
        json.sns_wechat contact.sns_wechat
        json.message contact.message
        json.created_at contact.created_at
        json.return_way contact.return_way
        json.subject contact.subject
      end
    end
  end


end
