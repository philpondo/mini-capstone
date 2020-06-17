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

    @carted_products = CartedProduct.where(user_id: current_user.id, status: 'carted')

    calculated_subtotal = @carted_products.map { |carted_product| carted_product.product.price * carted_product.quantity}.sum
    calculated_tax = calculated_subtotal * 0.09
    calculate_total = calculated_subtotal + calculated_tax
    @order = Order.new(
      user_id: current_user.id,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculate_total
    )
    if @order.save
      @carted_products.update_all(order_id: @order.id, status: "purchased")
      render 'show.json.jb'
    else
      render json: {error: @order.errors.full_messages}, status: :unprocessable_entity
    end

  end

end
