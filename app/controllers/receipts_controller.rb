class ReceiptsController < ApplicationController
  def index
    render json: { shit: true }
  end

  def create
    # TODO: create items
    render json: Party.where(chat_id: -220834405).last.as_json
  end
end
