class StocksController < ApplicationController
  def index
    @stocks = Stock.all.includes(:market_price, :bearer)
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      # Was using render :show, but RSpec gave me issues
      render "stocks/show.json.jbuilder", status: :created
    else
      render_error
    end
  end

  def update
    @stock = Stock.find(params[:id])
    if @stock.update(stock_params)
      # Was using render :show, but RSpec gave me issues
      render "stocks/show.json.jbuilder", status: :ok
    else
      render_error
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:currency, :name, :bearer_name, :value_cents)
  end

  def render_error
    render json: { errors: @stock.errors },
      status: :unprocessable_entity
  end
end
