class Coupon < ApplicationRecord
  belongs_to :shop, polymorphic: true
  belongs_to :coupon, polymorphic: true

  def self.default_shop_coupons
    now = Time.zone.now
    return self.where("coupons.started_at <= ? and (coupons.end_at > ? or coupons.end_at is null)",now,now).order("coupons.sort_no asc")
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.subject_id self.subject_id
      json.description self.description
      json.sub_description self.sub_description
      json.started_at self.started_at
      json.end_at self.end_at
      json.is_displayed self.is_displayed
      json.sort_no self.sort_no
    end
  end

  def self.to_jbuilders(coupons)
    Jbuilder.new do |json|
      json.array! coupons do |coupon|
        json.id coupon.id
        json.type coupon.type
        json.subject_id coupon.subject_id
        json.description coupon.description
        json.sub_description coupon.sub_description
        json.started_at coupon.started_at
        json.end_at coupon.end_at
        json.is_displayed coupon.is_displayed
        json.sort_no coupon.sort_no
      end
    end
  end

  
end
