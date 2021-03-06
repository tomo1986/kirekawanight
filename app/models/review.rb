class Review < ApplicationRecord
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  has_many  :references, class_name: 'PostType::Reference', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :not_references, class_name: 'PostType::NotReference', as: :receiver, dependent: :destroy, :autosave => true

  before_save do
    self.total_score = (self.score1 + self.score2 + self.score3 + self.score4 + self.score5)
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.sender_type self.sender_type
      json.sender_id self.sender_id
      json.receiver_type self.receiver_type
      json.receiver_id self.receiver_id
      json.score1 self.score1
      json.score2 self.score2
      json.score3 self.score3
      json.score4 self.score4
      json.score5 self.score5
      json.info1 self.info1
      json.info2 self.info2
      json.info3 self.info3
      json.info4 self.info4
      json.info5 self.info5
      json.is_draft self.is_draft
      json.title self.title
      json.comment self.comment
      json.opinion self.opinion
      json.created_at self.created_at
      json.is_displayed self.is_displayed
      json.sender self.sender.to_jbuilder
      json.receiver self.receiver.to_jbuilder
      json.total_score self.total_score
      json.sender_review_count self.sender.review_shops ? (self.sender.review_shops.count + self.sender.review_users.count) : 0
      json.reference_count self.references.count
      json.not_reference_count self.not_references.count

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
        json.score1 review.score1
        json.score2 review.score2
        json.score3 review.score3
        json.score4 review.score4
        json.score5 review.score5
        json.info1 review.info1
        json.info2 review.info2
        json.info3 review.info3
        json.info4 review.info4
        json.info5 review.info5
        json.is_draft review.is_draft
        json.title review.title
        json.comment review.comment
        json.opinion review.opinion
        json.total_score review.total_score
        json.created_at review.created_at
        json.is_displayed review.is_displayed
        json.sender review.sender.to_jbuilder
        json.sender_review_count (review.sender.review_shops.count + review.sender.review_users.count)
        json.receiver review.receiver.to_jbuilder
        json.reference_count review.references.count
        json.not_reference_count review.not_references.count
        # json.receiver review.receiver.to_jbuilder

      end
    end
  end

end
