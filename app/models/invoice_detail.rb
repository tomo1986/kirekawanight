class InvoiceDetail < ApplicationRecord
  belongs_to :invoice

  # before_save do
  #   sub_amount = 0
  #   total = 0
  #   invoice = Invoice.find_by(id: self.invoice_id)
  #   sub_amount = InvoiceDetail.put_total_sub_amount(invoice.invoice_details)
  #   total = InvoiceDetail.put_total_amount(invoice.invoice_details)
  #   invoice.attributes={sub_amount: sub_amount,total: total}
  #   invoice.save
  # end
  #
  #
  # def test
  #   sub_amount = 0
  #   total = 0
  #   invoice = Invoice.find_by(id: self.invoice_id)
  #   sub_amount = InvoiceDetail.put_total_sub_amount(invoice.invoice_details)
  #   total = InvoiceDetail.put_total_amount(invoice.invoice_details)
  #   invoice.attributes={sub_amount: sub_amount,total: total}
  #   invoice.save
  #
  # end


  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.invoice_id self.invoice_id
      json.name self.name
      json.quantilty self.quantilty
      json.unit_price self.unit_price
      json.category self.category
      json.tax_rate self.tax_rate
      json.created_at self.created_at
      json.updated_at self.updated_at
    end
  end

  def self.to_jbuilders(invoice_details)
    Jbuilder.new do |json|
      json.array! invoice_details do |invoice_detail|
        json.id invoice_detail.id
        json.invoice_id invoice_detail.invoice_id
        json.name invoice_detail.name
        json.quantilty invoice_detail.quantilty
        json.unit_price invoice_detail.unit_price
        json.category invoice_detail.category
        json.tax_rate invoice_detail.tax_rate
        json.created_at invoice_detail.created_at
        json.updated_at invoice_detail.updated_at
      end
    end
  end
  def self.pay_total_kickback(invoice_details)
    total_kickback_amount = 0
    invoice_details.each do |invoice_detail|
      total_kickback_amount = total_kickback_amount + invoice_detail.pay_kickback
    end
    return total_kickback_amount
  end
  def self.get_total_remainder(invoice_details)
    total_remainder_amount = 0
    invoice_details.each do |invoice_detail|
      total_remainder_amount = total_remainder_amount + invoice_detail.get_remainder
    end
    return total_remainder_amount
  end
  def self.put_total_sub_amount(invoice_details)
    total_sub_amount = 0
    invoice_details.each do |invoice_detail|
      total_sub_amount = total_sub_amount + invoice_detail.put_sub_amount
    end
    return total_sub_amount
  end

  def self.put_total_amount(invoice_details)
    total_amount = 0
    invoice_details.each do |invoice_detail|
      total_amount = total_amount + invoice_detail.including_tax
    end
    return total_amount
  end



  def get_remainder
    return self.put_sub_amount if self.kickback_rate.blank?
    return (self.put_sub_amount * ((100 - self.kickback_rate).round(2) / 100)).round
  end

  def pay_kickback
    return 0 if self.kickback_rate.blank?
    # return (((self.quantilty * self.unit_price) * self.kickback_rate / 100) * ((100 + self.invoice.tax_rate) / 100.0)).round
    return ((self.put_sub_amount * self.kickback_rate / 100)).round
  end

  def put_sub_amount
    return self.quantilty * self.unit_price
  end

  def including_tax
    return ( self.put_sub_amount  * ((100 + self.set_tax_rate) / 100.0)).round
  end

  def set_tax_rate
    return self.tax_rate ? self.tax_rate : Settings.tax_rate
  end


end
