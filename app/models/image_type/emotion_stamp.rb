class ImageType::EmotionStamp < Image

  #------------------- begin accessors ---------------------#
  #------------------- begin associations ------------------#
  #------------------- begin module ------------------------#
  #------------------- begin validations -------------------#
  #------------------- begin named scopes ------------------#
  #------------------- begin external libraries ------------#
  has_attached_file :image, {
      :default_url => :default_url,
      styles:  {
          medium: ['200x222', :png],
          original: [:png]
      }
  }
  #------------------- begin callback ----------------------#
  #------------------- begin class methods -----------------#
  #------------------- begin instance methods --------------#

  def default_url
    ''
  end

end
