class Media < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.subject_type self.subject_type
      json.subject_id self.subject_id
      json.script self.script
      json.is_displayed self.is_displayed
    end
  end
end
