class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :works
  has_many :comments

  with_options presence: true do
    validates :nickname,   uniqueness:{case_sensitive: false}
    validates :email,      uniqueness: { case_sensitive: false }, format: { with: /@/ }
    validates :password,   length: { minimum: 8 }, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
    validates :tel,        numericality: { only_integer: true, }
  end
end
