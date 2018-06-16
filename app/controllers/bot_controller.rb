class BotController < Telegram::Bot::UpdatesController
  # use callbacks like in any other controllers
  around_action :with_locale

  def message(message)
    message == self.payload # true
  end

  def start!(data = nil, *)
    response = from ? "Hello #{from['username']}!" : 'Hi there!'
    # There is `respond_with` helper to set `chat_id` from received message:
    respond_with :message, text: response
    # `reply_with` also sets `reply_to_message_id`:
    reply_with :photo, photo: File.open('party.jpg')
  end

  private

  def with_locale(&block)
    I18n.with_locale(locale_for_update, &block)
  end

  def locale_for_update
    if from
      # locale for user
    elsif chat
      # locale for chat
    end
  end
end
