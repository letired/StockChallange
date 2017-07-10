require 'rails_helper'

RSpec.describe StocksController, type: :controller do

  describe "GET /stocks/" do
    FactoryGirl.build(:stock)
    it "should return list with stocks" do
      get "stocks", as: :json
      expect(response).to have_http_status(200)
      expect(response.body).to eq("hello")
    end
  end

  describe "POST /stocks/" do
    context "with valid data" do
      it "should return stock and 201 created OK" do

        params = { stock: { name: "Microsoft", bearer_name: "Billy Bob", value_cents: 1939, currency: "EUR"} }

        post :create, as: :json, params: params

        expect(response).to have_http_status(201)
        expect(response).to render_template(:show)
        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(1)
      end
    end

    context "with invalid data" do
      it "should return 422 and fail to save" do

        params = { stock: { name: "invalid", bearer_name: "invalid", value_cents: 1939, currency: "EUR"} }

        post :create, as: :json, params: params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)).to eq({"errors"=>{"name"=>["is invalid"], "bearer_name"=>["is invalid"]}})
        expect(Stock.count).to eq(0)
        expect(Bearer.count).to eq(0)
        expect(MarketPrice.count).to eq(0)

      end
    end
  end

  describe "PATCH /stocks/:id" do
    context "with different bearer" do
      it "should create new bearer but keep market price"
    end

    context "with different market price" do
      it "should create new market price but keep bearer"
    end

    context "with existing bearer" do
      it "should reference existing bearer to stock"
    end
  end

  describe "DELETE /stocks/:id" do
    context "with different bearer" do
      it "should create new bearer but keep market price"
    end
  end

end
