Rails.application.routes.draw do
  resources :stocks, defaults: { format: :json }, only: [ :index, :show, :create, :update, :delete ] do
  end
end
