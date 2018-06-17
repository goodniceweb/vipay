require "google/cloud/vision"

class ReceiptsController < ApplicationController
  def index
    render json: { shit: true }
  end

  def create
    path = Rails.root.join("shit.jpg")
    File.open(path, "wb") { |f| f.write Base64.decode64(params[:image])  }
    vision = Google::Cloud::Vision.new
    image = vision.image path
    text = image.text
    puts text
    party = Party.where(chat_id: -220834405).last
    party.update_columns(total: "245.60") if party.total.blank?
    render json: party.as_json
  end
end
