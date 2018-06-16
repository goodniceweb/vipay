class User < ApplicationRecord
  def nickname
    return "@#{username}" if username.present?
    username.first_name
  end
end
