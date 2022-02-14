class Article < ApplicationRecord
    #many to one association with user
    belongs_to :user

    #many to many association with categories
    has_many :article_categories
    has_many :categories, through: :article_categories

    validates :title, presence: true, length: { minimum: 2, maximum: 100 }
    validates :description, presence: true, length: { minimum: 5, maximum: 300 }     
 
end