class Api::ProductsController < ApplicationController

  def all_products
    @all_products = Product.all
    render 'all_products.json.jb'
  end

  def single_product
    @single_product = Product.all.sample
    render 'single_product.json.jb'
  end

  def any_product
    @any_product = Product.find_by(id: params[:id])
    render 'any_product.json.jb'
  end

end
