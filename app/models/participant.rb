require 'digest/md5'

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :participant_item
  has_one :invoice

  def name
    user.first_name
  end

  def color
    return '6b08d6' if name == 'Victor'
    return 'f92e27' if name == 'Alex'
    return '56af5c' if name == 'Kirill'
    return '0b2e84' if name == 'Tatiana'
    'b6bc00'
  end
end
