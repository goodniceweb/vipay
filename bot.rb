require 'pry'
gem 'telegram-bot-ruby'

require 'telegram/bot'

Telegram::Bot::Client.run('600521389:AAGGt9Ptz0fDF7jfBhrL-XS-7hs9N6cXWUA', logger: Logger.new($stdout)) do |bot|
  begin
    bot.listen do |message|
      binding.pry
      case message.text
       when '/start', '/start@bot_name'
         message_text = "Hi #{message.from.first_name}, here is a list of commands: \n
        /calls - _List of calls_ \n
        /duty - _Duty list_ \n
        /requests - _Requests statistic_"
        bot.api.send_message(chat_id: message.chat.id, text: message_text, parse_mode: 'Markdown')
      end
    end
  end
end
