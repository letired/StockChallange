class StocksController < ApplicationController
  def index
    # This style of loading will load the relevant data for market price and bearer as well,
    # no more N+1!  I couldn't figure out how to do this in a single SQL query though.
    @stocks = Stock.all.includes(:market_price, :bearer)
  end

  def show
    @stock = Stock.find(params[:id])
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
    @stock = Stock.find(params[:id])
    if @stock.update(stock_params)
      render :show, status: :ok
    else
      render_error
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    if @stock.destroy
      render :index, status: :ok
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
