class Api::OrdersController < ApplicationController

  before_action :authenticate_user

  def index
    @orders = current_user.orders
    render 'index.json.jb'
  end

  def show
    @order = Order.find(params[:id])
    render 'show.json.jb'
  end
  
  def create
    product = Product.find_by(id: params[:product_id])
    calculated_subtotal = product.price * params[:quantity].to_i
    calculated_tax = calculated_subtotal * 0.09
    calculate_total = calculated_subtotal + calculated_tax
    @order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculate_total
    )
    if @order.save
      render 'show.json.jb'
    else
      render json: {error: @order.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
