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

class ImageType::Url < Image
  #------------------------------- begin accessors ---------------------------------#
  #------------------------------- begin associations ------------------------------#
  #------------------------------- begin module ------------------------------------#
  #------------------------------- begin validations -------------------------------#
  #------------------------------- begin named scopes ------------------------------#
  #------------------------------- begin external libraries ------------------------#
  has_attached_file :image, {
      :default_url => :default_url,
      styles:  {
          original: ['', :png]
      }
  }

  #------------------------------- begin callback ----------------------------------#
  #------------------------------- begin class methods -----------------------------#
  #------------------------------- begin instance methods --------------------------#

end
