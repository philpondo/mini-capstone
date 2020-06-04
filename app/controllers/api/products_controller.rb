class Api::ProductsController < ApplicationController

  def index
    @products = Product.all
    render 'index.json.jb'
  end

  def show
    @product = Product.find_by(id: params[:id])
    render 'show.json.jb'
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description],
      inventory: params[:inventory]
    )
    if @product.save #happy path
      render 'show.json.jb'
    else #sad path
      render json: {errors: @product.errors.full_messages}
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.image_url = params[:image_url] || @product.image_url
    @product.description = params[:description] || @product.description
    @product.inventory = params[:inventory] || @product.inventory

    if @product.save #happy path
      render 'show.json.jb'
    else #sad path
      render json: {errors: @product.errors.full_messages}
    end
  end
  
  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: {message: "Recipe was successfully deleted."}
  end

end
