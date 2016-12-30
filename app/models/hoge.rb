require 'net/https'
require 'uri'
class Hoge < ActiveRecord::Base

  def self.create_monthly_invoices
    STDOUT.puts "-------#{Time.now.strftime('%d/%m/%y-%H:%M:%S')}--- force to start delayed job ----------"
    now = Time.zone.now
    from = now.beginning_of_month
    to = now.end_of_month
    due_date = Time.zone.local(now.year,now.month,25).next_month

    shops = Shop.where(deleted_at: nil)
    shops.each do |shop|
      sql = shop.invoice_sql
      next if sql.blank?
      Hoge.connect_datebase
      result = Hoge.connection.select_all(sql)
      Hoge.connection.close
      invoice = Invoice.new
      sub_amount = 0
      total_amount = 0

      result.rows.each do |row|
        invoice.invoice_details.build(
            name: row[0],quantilty: row[1],unit_price: row[2],category: row[3],tax_rate: row[4]
        )
        sub_amount = sub_amount + (row[1] * row[2])
        total_amount = total_amount + ((row[1] * row[2]) * ((100 + row[4].to_i) / 100.0)).round
      end
      shop_pickups = Pickup.where(subject_type: 'Shop', subject_id: shop.id, start_at: from...to)
      shop_pickups.each do |pickup|
        next if pickup.price.blank? || pickup.price == 0
        invoice.invoice_details.build(
            name: "Shop pickup cost(#{pickup.start_at.strftime('%Y/%m/%d')}〜)", quantilty: 1,unit_price: pickup.price ,category: 'pickup',tax_rate: Settings.tax_rate
        )
        sub_amount = sub_amount + (pickup.price * 1)
        total_amount = total_amount + ((pickup.price * 1) * ((100 + Settings.tax_rate.to_i) / 100.0)).round
      end

      user_ids = shop.users.ids if shop.users
      user_pickups = Pickup.where(subject_type: 'User', subject_id: user_ids, start_at: from...to) if user_ids
      user_pickups.each do |pickup|
        next if pickup.price.blank? || pickup.price == 0
        invoice.invoice_details.build(
            name: "#{User.find_by(id: pickup.subject_id).name} pickup cost(#{pickup.start_at.strftime('%Y/%m/%d')}〜)", quantilty: 1,unit_price: pickup.price ,category: 'pickup',tax_rate: Settings.tax_rate
        )
        sub_amount = sub_amount + (pickup.price * 1)
        total_amount = total_amount + ((pickup.price * 1) * ((100 + Settings.tax_rate.to_i) / 100.0)).round
      end


      admin = Admin.find(shop.admin_id) if shop.admin_id

      invoice.attributes={
          shop_id: shop.id,
          admin_id: admin.present? ? admin.id : nil,
          period_from: Time.zone.local(now.year,now.month).prev_month,
          period_to: Time.zone.local(now.year,now.month),
          due_date: due_date,
          sub_amount: sub_amount,
          total: total_amount,
          sales_person: admin.present? ? admin.name : Settings.sales_person
      }
      invoice.save
    end
  end

  private

  def self.connect_datebase
    Hoge.establish_connection(
        :adapter=>"mysql2",
        :host  => '27.133.131.74',
        :database => 'mb_base46_production',
        :username => 'cimos',
        :password => 'MOAZgeSPu9Fa8QcuiQBZ',
        :encoding => "utf8",
        :port => 3306
    )
  end




end
