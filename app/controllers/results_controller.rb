require 'telegram/bot'

class ResultsController < ApplicationController
  # needs json in the following format:
  # {
  #   :party_id,
  #   items: [
  #     :id,
  #     users: [ :user_id ]
  #   ]
  # }
  def create
    user_ids = []
    params[:items].each do |item_hash|
      item = Item.find_by(id: item_hash[:id])
      next if item.blank?
      user_amount = item.amount.to_f / item_hash[:users].size

      item_hash[:users].each do |user_id|
        user_ids.push(user_id)
        ParticipantItem.create!(
          participant_id: user_id,
          amount: user_amount,
          item_id: item.id
        )
      end
    end

    party = Party.find_by(id: params[:party_id])
    Telegram::Bot::Client.run('600521389:AAGGt9Ptz0fDF7jfBhrL-XS-7hs9N6cXWUA', logger: Logger.new($stdout)) do |bot|
      bot.api.send_photo(chat_id: party.chat_id, photo: Faraday::UploadIO.new(Rails.root.join('check4.jpg'), 'image/jpeg'))
      user_ids.uniq.each do |user_id|
        user = User.find_by(id: user_id)
        msg = "Привет, #{user.nickname}. Мы вчера хорошо потусили. Не забудь, пожалуйста, скинуться деньгами. "
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Заплатить', url: 'https://mybank.by/main_unauthorised')
        ])
        bot.api.send_message(chat_id: party.chat_id, text: msg, reply_markup: markup)
      end
    end
    #  json: {
    #     party_id: 1,
    #     total: 245.60,
    #     items: [
    #       { id: 1, amount: 2, name: "potato", price: "50", total: "100", users: [id1, ] },
    #       { id: 2, amount: 1, name: "cola", price: "5.60", total: "5.60" },
    #       { id: 3, amount: 1, name: "pizza", price: "40", total: "40" }
    #     ]
    #   }
  end
end
