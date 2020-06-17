class Order < ApplicationRecord
  
  has_many :carted_products
  has_many :products, through: :carted_products
  belongs_to :user

end
