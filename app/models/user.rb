class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :image, presence: true
    
    has_many :posts
    has_many :favorites, dependent: :destroy
    has_many :favorite_posts, through: :favorites, source: :post

    has_secure_password
    mount_uploader :image, ImageUploader

end
