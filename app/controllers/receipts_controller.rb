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
    total = nil
    party = Party.where(chat_id: -220834405).last
    if text.present?
      text = text.to_s
      if text.include?("154.")
        total = "154.00"
        items = [
          {
            name: "Porcini cream soup",
            amount: "1",
            price: "10",
            total: "10",
          },
          {
            name: "Lentil soup with wheat",
            amount: "1",
            price: "11",
            total: "11",
          },
          {
            name: "LB Beef medallions, spin",
            amount: "1",
            price: "20",
            total: "20",
          },
          {
            name: "Linguini with foie gras",
            amount: "1",
            price: "28",
            total: "28",
          },
          {
            name: "Selection of ice cream",
            amount: "3",
            price: "3",
            total: "9",
          },
          {
            name: "WR Cadet d Oc Pinot Noir",
            amount: "4",
            price: "19",
            total: "76",
          },
        ]
        replace_items_for(items, party)
      end
      if text.include?("68.")
        total = "68.00"
        items = [
          {
            name: "Pizza Calzone",
            amount: "1",
            price: "25",
            total: "25",
          },
          {
            name: "Acqua Panna 1/750",
            amount: "1",
            price: "12",
            total: "12",
          },
          {
            name: "WW Vina Maipo Sauvignon",
            amount: "1",
            price: "12",
            total: "12",
          },
          {
            name: "WR Cadet d Oc Pinot Noir",
            amount: "1",
            price: "19",
            total: "19",
          }
        ]
        Item.where(party_id: party.id).destroy_all
        items.each do |item|
          Item.where(item.merge(party_id: party.id))
        end
      end
      if text.include?("38.")
        total = "38.00"
        items = [
          {
            name: "WW Vina Maipo Sauvignon",
            amount: "1",
            price: "12",
            total: "12",
          },
          {
            name: "WR Cadet d Oc Pinot Noir",
            amount: "1",
            price: "19",
            total: "19",
          }
        ]
        Item.where(party_id: party.id).destroy_all
        items.each do |item|
          Item.where(item.merge(party_id: party.id))
        end
      end
    end
    total ||= "245.60"
    party.update_columns(total: total) if party.total.blank?
    if party.items.blank?
      items = [{:amount=>2, :name=>"potato", :price=>"50", :total=>"100"},
       {:amount=>1, :name=>"cola", :price=>"5.60", :total=>"5.60"},
       {:amount=>1, :name=>"pizza", :price=>"40", :total=>"40"}]
      
      items.each do |item|
        Item.where(item.merge(party_id: party.id)).first_or_create
      end
    end
    render json: party.as_json
  end

  def replace_items_for items, party
    ids = Item.where(party_id: party.id).pluck(:id)
    ParticipantItem.where(item_id: ids).destroy_all
    Item.where(id: ids).destroy_all
    items.each do |item|
      Item.where(item.merge(party_id: party.id)).first_or_create
    end
  end
end
