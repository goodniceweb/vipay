class ReceiptsController < ApplicationController
  def index
    render json: { shit: true }
  end

  def create
    render json: { party_id: 1, total: 245.60 }
  end
end
