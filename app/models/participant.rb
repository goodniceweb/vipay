require 'digest/md5'

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :participant_item

  def name
    user.first_name
  end

  def color
    first_name = user.first_name
    return '6b08d6' if first_name == 'Victor'
    return 'f92e27' if first_name == 'Alex'
    return '56af5c' if first_name == 'Kirill'
    return '0b2e84' if first_name == 'Tatiana'
    'b6bc00'
  end
end
