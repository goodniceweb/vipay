require 'digest/md5'

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :participant_item

  def name
    user.first_name
  end

  def color
    Digest::MD5.hexdigest(name)[0..5]
  end
end
