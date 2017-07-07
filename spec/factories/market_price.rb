FactoryGirl.define do
  factory :market_price do

    value_cents 1939
    currency "EUR"

  end

  factory :market_price_2, class: MarketPrice do

    value_cents 1939
    currency "USD"

  end
end
