class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  validates :name, :email, presence: true #:password_digest, presence: true
  #validates_uniqueness_of :email, { case_sensitive: false }
  #has_secure_password
  before_save { self.email = email.downcase }

  def friends
    User.all.where.not(id: id)
  end
end

