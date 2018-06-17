require 'telegram/bot'

namespace :scheduler do
  task :set => :environment do |task, args|
    Telegram::Bot::Client.run('600521389:AAGGt9Ptz0fDF7jfBhrL-XS-7hs9N6cXWUA', logger: Logger.new($stdout)) do |bot|
      bot.listen do |message|
        if message.text.present?
          if message.text.include?("@vipay_bot /start")
            msg = "Привет всем. Кто тусит,"
            bot.api.send_message(chat_id: message.chat.id, text: msg)            # case message.text
          end

          if message.text.include?("+1")
            user_params = message.from

            user = User.find_or_create_by(first_name: user_params.first_name,
                                           last_name: user_params.last_name,
                                           telegram_id: user_params.id)

            party = Party.where(chat_id: message.chat.id).first_or_create
            Participant.find_or_create_by(user_id: user.id, party_id: party.id)

            bot.api.send_message(chat_id: message.chat.id, text: "Добавил #{user.first_name} в тусу")            # case message.text
          end

          if message.text.include?("list")
            party = Party.where(chat_id: message.chat.id).last
            names = Participant.where(party_id: party.id).map(&:name)

            bot.api.send_message(chat_id: message.chat.id, text: "В тусе: #{names.join(', ')}")            # case message.text
            bot.api.send_message(chat_id: message.chat.id, text: "#{names.count} человечкa")            # case message.text
          end
        end
        # bot.api.send_message(chat_id: message.chat.id, text: message_text, parse_mode: 'Markdown')
      end
    end
  end
end
