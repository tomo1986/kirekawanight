class Event < ApplicationRecord

  belongs_to :subject, polymorphic: true

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.subject_type self.subject_type
      json.subject_id self.subject_id
      json.title self.title
      json.sub_title self.sub_title
      json.description self.description
      json.started_at self.started_at
      json.end_at self.end_at
      json.is_displayed self.is_displayed
      json.subject self.subject.class == Shop ? self.subject.to_event_jbuilder : nil
    end
  end

  def self.to_jbuilders(events)
    Jbuilder.new do |json|
      json.array! events do |event|
        json.id event.id
        json.type event.type
        json.subject_type event.subject_type
        json.subject_id event.subject_id
        json.title event.title
        json.sub_title event.sub_title
        json.description event.description
        json.started_at event.started_at
        json.end_at event.end_at
        json.is_displayed event.is_displayed
        json.subject event.subject.class == Shop ? event.subject.to_event_jbuilder : nil

      end
    end
  end

 def self.to_shop_events_jbuilders(events)
    Jbuilder.new do |json|
      json.array! events do |event|
        json.id event.id
        json.type event.type
        json.subject_type event.subject_type
        json.subject_id event.subject_id
        json.title event.title
        json.sub_title event.sub_title
        json.started_at event.started_at
        json.end_at event.end_at

      end
    end
  end

  def self.to_front_jbuilders(events)
    Jbuilder.new do |json|
      json.array! events do |event|
        json.id event.id
        json.type event.type
        json.subject_type event.subject_type
        json.subject_id event.subject_id
        json.title event.title
        json.sub_title event.sub_title
        json.description event.description
        json.started_at event.started_at
        json.end_at event.end_at
        json.is_displayed event.is_displayed
        json.subject event.subject.class == Shop ? event.subject.to_event_jbuilder : nil
      end
    end
  end





end
