class User < ActiveRecord::Base
  include BCrypt
  has_many :rounds
  has_many :decks, through: :rounds

  validates :username, :password_hash, presence: true
  validates :username, uniqueness: true
 
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
