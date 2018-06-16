Rails.application.routes.draw do
  root to: "receipts#index"
  resources :receipts
end
