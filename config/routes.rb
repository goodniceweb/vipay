Rails.application.routes.draw do
  root to: "receipts#index"
  resources :receipts
  resources :participants do
    collection do
      delete 'remove'
    end
  end
end
