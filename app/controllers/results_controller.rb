class ResultsController < ApplicationController
  def create
    params[:items].each do |item|
      user_amount = item.amount.to_f / item.users.count

       item.users.each do |user_id|
         ParticipantItem.create!(participant_id: user_id,
                                amount: user_amount,
                                item_id: item.id)
       end
    end

  #  json: {
  #     party_id: 1,
  #     total: 245.60,
  #     items: [
  #       { id: 1, amount: 2, name: "potato", price: "50", total: "100", users: [id1, ] },
  #       { id: 2, amount: 1, name: "cola", price: "5.60", total: "5.60" },
  #       { id: 3, amount: 1, name: "pizza", price: "40", total: "40" }
  #     ]
  #   }
  end
end
