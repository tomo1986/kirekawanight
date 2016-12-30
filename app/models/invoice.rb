class Invoice < ApplicationRecord

  belongs_to :shop
  belongs_to :admin
  has_many :invoice_details, dependent: :destroy
  before_create do
    now = Time.zone.now
    if self.note.blank?
      note = "\n※アカウント #{Time.zone.local(now.year,now.month,25).strftime('%m月%d日')} 時点のものとなります。"
      self.note = note
    end
    self.sales_person =  Settings.sales_person if self.sales_person.blank?
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.shop_id self.shop_id
      json.admin_id self.admin_id
      json.staff self.admin_id ? Admin.find_by(id: self.admin_id) : nil
      json.shop self.shop ? self.shop.to_jbuilder : nil

      json.invoice_details  InvoiceDetail.where(invoice_id: self.id)
      json.due_date self.due_date
      json.paid_at self.paid_at
      json.issued_at self.issued_at
      json.sub_amount self.sub_amount
      json.total self.total
      json.note self.note
      json.sales_person self.sales_person
      json.period_from self.period_from
      json.period_to self.period_to
      json.created_at self.created_at
      json.updated_at self.updated_at
    end
  end

  def self.to_jbuilders(invoices)
    Jbuilder.new do |json|
      json.array! invoices do |invoice|
        json.id invoice.id
        json.shop_id invoice.shop_id
        json.admin_id invoice.admin_id

        json.staff invoice.admin_id ? Admin.find_by(id: invoice.admin_id) : nil
        json.shop invoice.shop ? invoice.shop.to_jbuilder : nil
        json.invoice_details  InvoiceDetail.where(invoice_id: invoice.id)
        json.due_date invoice.due_date
        json.paid_at invoice.paid_at
        json.issued_at invoice.issued_at
        json.sub_amount invoice.sub_amount
        json.total invoice.total
        json.note invoice.note
        json.sales_person invoice.sales_person
        json.period_from invoice.period_from
        json.period_to invoice.period_to
        json.created_at invoice.created_at
        json.updated_at invoice.updated_at
      end
    end
  end

end
