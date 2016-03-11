class User < ActiveRecord::Base
  validates :username, presence: true, length: { minimum: 4, maximum: 18 }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable #:omniauthable
end
