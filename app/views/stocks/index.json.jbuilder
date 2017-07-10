json.array! @stocks do |stock|
  json.stock do
    json.(stock, :id, :name)
  end
  json.market_price do
    json.(stock.market_price, :id, :value_cents, :currency)
  end
  json.bearer do
    json.(stock.bearer, :id, :name )
  end
end
