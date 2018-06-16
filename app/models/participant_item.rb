class ParticipantItem < ApplicationRecord
  belongs_to :participant
  belongs_to :item
end
