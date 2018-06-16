Rails.application.routes.draw do
  telegram_webhook BotController

  resources :receipts do
  end
end
