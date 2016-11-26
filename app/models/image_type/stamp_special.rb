class ImageType::StampSpecial < Image

  #------------------- begin accessors ---------------------#
  #------------------- begin associations ------------------#
  #------------------- begin module ------------------------#
  #------------------- begin validations -------------------#
  #------------------- begin named scopes ------------------#
  #------------------- begin external libraries ------------#
  has_attached_file :image, {
      :default_url => :default_url,
      styles:  {
          smal: ['60x60', :png],
          medium: ['200x200', :png],
          original: [:png]
      }
  }
  #------------------- begin callback ----------------------#
  #------------------- begin class methods -----------------#
  #------------------- begin instance methods --------------#

  def default_url
    ActionController::Base.helpers.asset_path('stamp/default.png')
  end
end
