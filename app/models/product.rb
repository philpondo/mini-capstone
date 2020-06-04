class Product < ApplicationRecord
  
  validates :name, length: { in: 1..100 }, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { in: 10..500 }
  
  def is_discounted?
    price < 10
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

  def available?
    if inventory == 0
      "This product is currently out of stock."
    else
      "#{inventory} units in stock."
    end
  end
end
