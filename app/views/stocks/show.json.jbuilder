json.stock_name @stock.name
json.extract! @stock.market_price, :value_cents, :currency
json.bearer_name @stock.bearer.name
