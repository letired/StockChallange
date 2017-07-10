json.stock_name @stock.name
json.extract! @stock.market_price, :value_cents, :currency
json.bearer @stock.bearer.name
