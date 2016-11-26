class ImageType::Tweet < Image
  #------------------------------- begin accessors ---------------------------------#
  #------------------------------- begin associations ------------------------------#
  #------------------------------- begin module ------------------------------------#
  #------------------------------- begin validations -------------------------------#
  #------------------------------- begin named scopes ------------------------------#
  #------------------------------- begin external libraries ------------------------#
  has_attached_file :image, {
      :default_url => :default_url,
      styles:  {
          small: ['120x120', :png],
          large: ['400x400', :png],
          big: ['600x600', :png],
          original: ['', :png]
      }
  }

  #------------------------------- begin callback ----------------------------------#
  #------------------------------- begin class methods -----------------------------#
  #------------------------------- begin instance methods --------------------------#
  #
  def default_url
    return '' #ActionController::Base.helpers.asset_path('common/no-image.png')
  end

  def self.to_builder(images,type = :original) 
    Jbuilder.new do |json|
      json.array!(images) do |image|
        json.id image.id
        json.image_url image.url(type)
      end  
    end
  end
end
