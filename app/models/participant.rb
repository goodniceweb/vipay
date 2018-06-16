require 'digest/md5'

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :participant_item

  def name
    user.first_name
  end

  def color
    return '6b08d6' first_name == 'Victor'
    return 'f92e27' first_name == 'Alex'
    return '56af5c' first_name == 'Kirill'
    return '0b2e84' first_name == 'Tatiana'
    'b6bc00'
  end
end
