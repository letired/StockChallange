require 'rails_helper'

RSpec.describe StocksController, type: :controller do

  # I have read testing views in controller isn't best practice, but this seemed simpler
  render_views

  describe "GET /stocks/" do
    it "should return list with stocks" do
      @subject = FactoryGirl.create(:stock)
      get :index, as: :json
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq([
    {
        "stock"=>{
            "id"=>1,
            "name"=>"New Stock"
        },
        "market_price"=>{
            "id"=>1,
            "value_cents"=>1939,
            "currency"=>"EUR"
        },
        "bearer"=>{
            "id"=>1,
            "name"=>"Me"
        }
    }])
    end
  end

  describe "POST /stocks/" do
    context "with valid data" do
      it "should return stock and 201 created OK" do

        params = { stock: { name: "Microsoft", bearer_name: "Billy Bob", value_cents: 1939, currency: "EUR"} }

        post :create, as: :json, params: params

        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)).to eq({
          "stock_name"=>"Microsoft",
          "value_cents"=>1939,
          "currency"=>"EUR",
          "bearer_name"=>"Billy Bob"
          })
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

    context "with no currency value" do
      it "should return 422 and fail to save" do
        params = { stock: { name: "Microsoft", bearer_name: "Spencer", value_cents: 800} }

        post :create, as: :json, params: params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)).to eq("errors" => {"market_price"=>["must exist"]})
        expect(Stock.count).to eq(0)
        expect(Bearer.count).to eq(0)
        expect(MarketPrice.count).to eq(0)
      end
    end
  end

  describe "PATCH /stocks/:id" do
    context "with different bearer" do

      it "should create new bearer but keep market price" do
        FactoryGirl.create(:stock)

        params = { stock: { bearer_name: "doge"}, id: 1}

        patch :update, as: :json, params: params

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({
        "stock_name"=>"New Stock",
        "value_cents"=>1939,
        "currency"=>"EUR",
        "bearer_name"=>"doge"
        })
        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(2)
        expect(MarketPrice.count).to eq(1)
      end
    end

    context "with different market price" do
      it "should create new market price but keep bearer" do
        FactoryGirl.create(:stock)

        params = { stock: { value_cents: 555, currency: "USD"}, id: 1}

        patch :update, as: :json, params: params

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({
        "stock_name"=>"New Stock",
        "value_cents"=>555,
        "currency"=>"USD",
        "bearer_name"=>"Me"
        })
        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(2)
      end
    end

    context "with just value_cents and no currency" do
      it "should use previous currency associated with stock, and create new market price" do
          FactoryGirl.create(:stock)

          params = { stock: { value_cents: 555}, id: 1}

          patch :update, as: :json, params: params

          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)).to eq({
          "stock_name"=>"New Stock",
          "value_cents"=>555,
          "currency"=>"EUR",
          "bearer_name"=>"Me"
          })
          expect(Stock.count).to eq(1)
          expect(Bearer.count).to eq(1)
          expect(MarketPrice.count).to eq(2)
        end
      end

    context "with existing bearer" do
      it "should reference existing bearer to stock" do
        FactoryGirl.create(:stock)
        existing_bearer = Bearer.create(name: "Luke Skywalker")

        params = { stock: {bearer_name: "Luke Skywalker"}, id: 1}

        patch :update, as: :json, params: params

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({
        "stock_name"=>"New Stock",
        "value_cents"=>1939,
        "currency"=>"EUR",
        "bearer_name"=>"Luke Skywalker"
        })
        expect(Stock.find(1).bearer).to eq(existing_bearer)
        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(2)
        expect(MarketPrice.count).to eq(1)
      end
    end
  end

  describe "DELETE /stocks/:id" do
    it "should soft delete the stock" do
      FactoryGirl.create(:stock)

      params = {id: 1}

      delete :destroy, as: :json, params: params

      expect(response).to have_http_status(200)
      expect(Stock.count).to eq(0)
      expect(Bearer.count).to eq(1)
      expect(MarketPrice.count).to eq(1)
    end
  end
end
