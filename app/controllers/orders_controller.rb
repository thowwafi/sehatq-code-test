class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.calculate_total(params[:order][:qty].to_i)
    @order.product.update_quantity(params[:order][:qty].to_i)
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purchase
    @order = Order.find(params[:id])
    if @order.proceed!
      redirect_to orders_path, notice:"Your order has been placed"
    else
      redirect_to request.referrer, alert:"Something wrong"
    end
  end

  def cancel_purchase
    @order = Order.find(params[:id])
    if @order.cancel! && @order.product.return_quantity(params[:qty].to_i)
      redirect_to orders_path, notice:"Your order has been canceled"
    else
      redirect_to request.referrer, alert:"Something wrong"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:number, :qty, :total, :user_id, :state, :product_id)
    end
end
