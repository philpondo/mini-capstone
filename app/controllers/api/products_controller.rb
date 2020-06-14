class Api::ProductsController < ApplicationController

before_action :authenticate_admin, except: [:index, :show]

def index
  @products = Product.all
  
  if params[:category]
    category = Category.find_by(name: params[:category])
    @products = category.products
  end
  
  if params[:search]
    @products = @products.where("name iLIKE ?", "%#{params[:search]}%")
  end

  if params[:discount]
    @products = @products.is_discounted
  end

  if params[:sort] == "price"
    if params[:sort_order] == "asc"
      @products = @products.order(:price)
    elsif params[:sort_order] == "desc"
      @products = @products.order(price: :desc)
    end
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
    inventory: params[:inventory],
    supplier_id: params[:supplier_id]
  )
  if @product.save #happy path
    render 'show.json.jb'
  else #sad path
    render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
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
