class ProductsController < ApplicationController
  def index
    @products = Product.all
    render 'index.html.erb'
  end

  def show
    @product = Product.find(params[:id])
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      inventory: params[:inventory],
      supplier_id: params[:supplier_id]
    )
    if @product.save
      redirect_to "/products/#{@product.id}"
    else
      render json: {errors: @product.errors.full_messages}
    end
  end

  def edit
    @product = Product.find(params[:id])
    render 'edit.html.erb'
  end

  def update
    @product = Product.find(params[:id])
    @product.name = params[:name]
    @product.price = params[:price]
    @product.description = params[:description]
    @product.inventory = params[:inventory]
    @product.supplier_id = params[:supplier_id]
    if @product.save
      redirect_to "/products/#{@product.id}"
    else
      render json: {errors: @product.errors.full_messages}
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to "/products
  end

end
