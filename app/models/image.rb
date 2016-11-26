class Image < ApplicationRecord

  #------------------------------- begin accessors ---------------------------------#
  #------------------------------- begin associations ------------------------------#
  belongs_to :subject, polymorphic: true
  delegate :url, to: :image

  #------------------------------- begin module ------------------------------------#
  #------------------------------- begin validations -------------------------------#
  #------------------------------- begin named scopes ------------------------------#
  #------------------------------- begin external libraries ------------------------#
  has_attached_file :image
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png image/gif)
  #------------------------------- begin callback ----------------------------------#
  after_initialize :set_default
  before_save :extract_dimensions
  serialize :dimensions
  #------------------------------- begin class methods -----------------------------#
  #------------------------------- begin instance methods --------------------------#
  def set_default
    # override from sub class
  end

  def as_json(options = {})
    if options == {}
      super only: [ :image_file_name ]
    else
      super options
    end
  end

  def is_file
    return true if !self.image.nil? && self.image.respond_to?('path')
    return false
  end

  def image_type?
    image_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  def extract_dimensions
    return unless image_type?
    tempfile = image.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end

end
