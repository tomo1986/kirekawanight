class Discount < ApplicationRecord
  belongs_to :group

  scope :open_time_discounts, -> () {
    now = Time.zone.now
    return self.where('start_at <= ? and end_at > ?',now, now)
  }


  def make_content_ja
    if self.type == 'DiscountType::Time'
      type = "タイムセール"
    end
    content = ""
    content = content + "#{type}!!<br>"
    content = content + "#{self.groups}組様限定!!#{self.peoples}名以上のお客様で<br>"
    content = content + "#{self.start_at.strftime('%Y年%m月%d日%H時%M分')}〜#{self.end_at.strftime('%Y年%m月%d日%H時%M分')}の間に"
    content = content + "ご予約いただくと、お一人様#{self.price}USDで遊べます。<br>"
    content = content + "今すぐ<a href='tel:#{self.tel}'>#{self.tel}</a>にお電話ください！！合言葉は「キレカワ見ました！！」"
    return content
  end

  def status_discount
    return self.start_at.nil?
    now = Time.zone.now
    if self.start_at < now
      return 'wait'
    elsif now.between?(self.start_at, self.end_at)
      return 'open'
    else
      return 'finish'
    end
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.status self.status_discount
      json.type self.type
      json.groups self.groups
      json.peoples self.peoples
      json.price self.price
      json.content self.content
      json.watchword self.watchword
      json.start_at self.start_at
      json.end_at self.end_at
      json.tel self.tel
      json.is_displayed self.is_displayed
      json.group self.group.to_jbuilder
    end
  end

  def self.to_jbuilders(discounts)
    Jbuilder.new do |json|
      json.array! discounts do |discount|
        json.id discount.id
        json.status discount.status_discount
        json.type discount.type
        json.groups discount.groups
        json.peoples discount.peoples
        json.price discount.price
        json.content discount.content
        json.watchword discount.watchword
        json.start_at discount.start_at
        json.end_at discount.end_at
        json.tel discount.tel
        json.is_displayed discount.is_displayed
        json.group discount.group.to_jbuilder
      end
    end
  end



end
