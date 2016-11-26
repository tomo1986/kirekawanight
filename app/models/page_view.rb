class PageView < ApplicationRecord

  def self.counts_period(pvs=nil, from=nil, to=nil)
    return if pvs.blank?
    start_at = from ? from : Time.zone.now
    end_at = to ? to : Time.zone.now
    return pvs.where( created_at: start_at.beginning_of_day...end_at.end_of_day).count
  end

end
