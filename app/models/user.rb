class User < ActiveRecord::Base
  dragonfly_accessor :avatar
  include Avatarable

  has_many :posts, dependent: :destroy

  validates :username, presence: true, length: { minimum: 4, maximum: 18 }
  validates_property :format, of: :avatar, in: [:jpeg, :jpg, :png, :gif], case_sensitive: false

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable #:omniauthable

  def avatar_text
    self.username
  end
end
