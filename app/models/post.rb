class Post < ActiveRecord::Base
  dragonfly_accessor :image
  acts_as_votable

  belongs_to :user
  has_many :comments

  validates :user_id, presence: true
  validates_presence_of :image
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :gif], case_sensitive: false
end
