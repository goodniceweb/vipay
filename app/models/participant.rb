class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :participant_item

  def name
    user.first_name
  end
end
