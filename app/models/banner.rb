class Banner < ApplicationRecord
  belongs_to :subject, polymorphic: true
  has_one  :image, class_name: 'ImageType::Banner', as: :subject, dependent: :destroy, :autosave => true

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.subject_type self.subject_type
      json.subject_id self.subject_id
      json.title self.title
      json.link self.link
      json.is_target_blank self.is_target_blank
      json.article self.article
      json.start_at self.start_at
      json.end_at self.end_at
      json.created_at self.created_at
      json.set! :image do
        json.id self.image ? self.image.id : nil
        json.url self.image ? self.image.url : nil
      end

    end
  end

  def self.to_jbuilders(banners)
    Jbuilder.new do |json|
      json.array! banners do |banner|
        json.id banner.id
        json.type banner.type
        json.subject_type banner.subject_type
        json.subject_id banner.subject_id
        json.title banner.title
        json.link banner.link
        json.is_target_blank banner.is_target_blank
        json.article banner.article
        json.start_at banner.start_at
        json.end_at banner.end_at
        json.created_at banner.created_at
        json.set! :image do
          json.id banner.image ? banner.image.id : nil
          json.url banner.image ? banner.image.url : nil
        end
      end
    end
  end

  def image=(image_binary)
    self.build_image unless self.image
    image.image.save! if image_binary != ''
  end

end
