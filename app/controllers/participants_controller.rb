class ParticipantsController < ActionController::Base
  def create
    party = Party.find_by(id: params[:party_id])
    user = User.where(phone: params[:phone]).first_or_create
    if user.present? && party.present?
      participant = Participant.new(user_id: user.id, party_id: party.id)
      if participant.save
        render json: party.as_json
      else
        unprocessable
      end
    else
      unprocessable
    end
  end

  def remove
    party = Party.find_by(id: params[:party_id])
    user = User.find_by(phone: params[:phone])
    if user.present? && party.present?
      Participant.where(user_id: user.id, party_id: party.id).destroy_all
      render json: party.as_json
    else
      unprocessable
    end
  end

  private

  def unprocessable
    render json: { message: "Can't update participant" }, status: :unprocessable_entity
  end
end
