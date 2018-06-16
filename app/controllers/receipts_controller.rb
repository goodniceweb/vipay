class ReceiptsController < ApplicationController
  def index
    render json: { shit: true }
  end

  def create
    render json: {
      party_id: 1,
      total: 245.60,
      items: [
        { id: 1, amount: 2, name: "potato", price: "50", total: "100" },
        { id: 2, amount: 1, name: "cola", price: "5.60", total: "5.60" },
        { id: 3, amount: 1, name: "pizza", price: "40", total: "40" }
      ]
    }
  end
end
