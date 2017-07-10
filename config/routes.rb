Rails.application.routes.draw do
  resources :stocks, defaults: { format: :json }, only: [ :index, :show, :create, :update, :destroy ] do
  end
end
