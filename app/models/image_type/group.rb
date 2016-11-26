# == Schema Information
# Schema version: 20150804034834
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  type               :string(255)
#  subject_id         :integer
#  subject_type       :string(255)
#  dimensions         :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  deleted_at         :datetime
#

class ImageType::Group < Image
  #------------------------------- begin accessors ---------------------------------#

  #------------------------------- begin associations ------------------------------#

  #------------------------------- begin module ------------------------------------#

  #------------------------------- begin validations -------------------------------#

  #------------------------------- begin named scopes ------------------------------#

  #------------------------------- begin external libraries ------------------------#
  has_attached_file :image, {
      styles:  {
          thumb: ['60x60', :png],
          medium: ['150x150', :png],
          original: ['1038x692', :png]
      }
  }
  #------------------------------- begin callback ----------------------------------#

  #------------------------------- begin class methods -----------------------------#
  def self.default_image(txt)
    color = ['#ff0000','#FFC0CB','#800080','#0000FF','#008000','#FFFF00'].sample
    canvas = Magick::Image.new(300, 300){self.background_color = color}
    gc = Magick::Draw.new
    gc.pointsize = 150
    gc.fill = 'white'
    gc.font_weight = Magick::BoldWeight
    gc.gravity = Magick::CenterGravity
    gc.text(0,20,txt)
    gc.draw(canvas)
    temp_file = Tempfile.new(["default_avatar",".png"])
    canvas.write(temp_file.path)
    temp_file
  end
  #------------------------------- begin instance methods --------------------------#

end
