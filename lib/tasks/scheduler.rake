require 'telegram/bot'

namespace :scheduler do
  task :set => :environment do |task, args|
    Telegram::Bot::Client.run('600521389:AAGGt9Ptz0fDF7jfBhrL-XS-7hs9N6cXWUA', logger: Logger.new($stdout)) do |bot|
      bot.listen do |message|
        if message.text.present?
          if message.text.include?("@vipay_bot")
            # communication directly with our bot
            case message.text
            when include?("start")
            end
          else
            # also might be some useful messages
          end
        end
        # bot.api.send_message(chat_id: message.chat.id, text: message_text, parse_mode: 'Markdown')
      end
    end
  end
end
