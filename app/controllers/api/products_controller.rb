class Api::ProductsController < ApplicationController

  def index
    @products = Product.all
    if params[:search]
      @products = @products.where("name iLIKE ?", "%#{params[:search]}%")
    end
    if params[:discount]
      @products = @products.is_discounted
    end
    if params[:sort]
      @products = @products.all.order(params[:sort])
    else
      @products = @products.order(:id)
    end
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
