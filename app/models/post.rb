class Post < ActiveRecord::Base
  dragonfly_accessor :image

  validates_presence_of :image
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :gif], case_sensitive: false
end
