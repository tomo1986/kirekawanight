class Tag < ApplicationRecord

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.name self.name
      json.taggings_count self.taggings_count

    end
  end

  def self.to_jbuilders(tags)
    Jbuilder.new do |json|
      json.array! tags do |tag|
        json.id tag.id
        json.name tag.name
        json.taggings_count tag.taggings_count

      end
    end
  end


end
