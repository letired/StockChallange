class StocksController < ApplicationController
  def index
    @stocks = Stock.all.includes(:market_price, :bearer)
  end

  def show
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
  end

  private

  def stock_params
    params.require(:stock).permit( :name, :bearer, :value_cents, :currency )
  end

  def render_error
    render json: { errors: @stock.errors.full_messages },
      status: :unprocessable_entity
  end
end
