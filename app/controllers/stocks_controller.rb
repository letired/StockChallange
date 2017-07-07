class StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end

  def show
  end

  def create
  end

  def update
  end
end
