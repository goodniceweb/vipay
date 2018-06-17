class User < ApplicationRecord
  def nickname
    return "@#{username}" if username.present?
    first_name
  end

  def build_invoice_for(party)
    participant = Participant.find_by(user_id: id, party_id: party.id)
    return if participant.blank?
    invoice = Invoice.new(participant_id: participant.id, paid: false)
    items = ParticipantItem.joins(item: :party).where(parties: { id: party.id }).where(participant_id: participant.id)
    return if items.blank?
    total = items.map(&:total).map(&:to_f).reduce(:+)
    invoice.total = total
    return unless invoice.save
    items.update_all(invoice_id: invoice.id)
    invoice
  end
end
