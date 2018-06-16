class Party < ApplicationRecord
  has_many :items
  has_many :participants

  def as_json(options = {})
    super(options.merge(include: [:items, :participants]))
  end
end
