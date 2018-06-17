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
    participant_ids = []
    params[:items].each do |item_hash|
      item = Item.find_by(id: item_hash[:id])
      next if item.blank?
      user_amount = item.amount.to_f / item_hash[:users].size

      item_hash[:users].each do |participant_id|
        participant_ids.push(participant_id)
        ParticipantItem.create!(
          participant_id: participant_id,
          amount: user_amount,
          total: item.price.to_f * user_amount,
          item_id: item.id
        )
      end
    end

    party = Party.find_by(id: params[:partyId])
    Telegram::Bot::Client.run('600521389:AAGGt9Ptz0fDF7jfBhrL-XS-7hs9N6cXWUA', logger: Logger.new($stdout)) do |bot|
      path = './shit.jpg'
      bot.api.send_photo(chat_id: party.chat_id, photo: Faraday::UploadIO.new(path, 'image/jpeg'))

      participant_ids.uniq.each do |participant_id|
        participant = Participant.find_by(id: participant_id)
        next if participant.blank?
        user = participant.user
        next if user.blank?
        invoice = user.build_invoice_for(party)
        msg = "Привет, #{user.nickname}. Мы вчера хорошо потусили. Не забудь, пожалуйста, скинуться деньгами."
        msg += "Итого получилось: #{invoice.total}" if invoice.present?
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [[
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Заплатить', url: 'https://mybank.by/main_unauthorised')
        ]])
        bot.api.send_message(chat_id: user.telegram_id, text: msg, reply_markup: markup)
      end
    end
    render json: party.invoices.where(paid: false).as_json
  end
end
