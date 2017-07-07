# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
bearer_1 = Bearer.create(name: "Billy Bob")
bearer_2 = Bearer.create(name: "Georgie Porgie")
bearer_3 = Bearer.create(name: "Jon Snow")

market_price_1 = MarketPrice.create(currency: "USD", value_cents: 150)
market_price_2 = MarketPrice.create(currency: "USD", value_cents: 200)
market_price_3 = MarketPrice.create(currency: "EUR", value_cents: 200)

stocks = Stock.create([
  {name:"Microsoft", bearer: bearer_1, market_price: market_price_1},
  {name:"Microsoft", bearer: bearer_2, market_price: market_price_1},
  {name:"Microsoft", bearer: bearer_3, market_price: market_price_1},
  {name:"BMW Cars", bearer: bearer_2, market_price: market_price_3},
  {name:"BMW Cars", bearer: bearer_1, market_price: market_price_3}
  ])
