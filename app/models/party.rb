class Party < ApplicationRecord
  has_many :items, dependent: :nullify
  has_many :participants
  has_many :invoices, through: :participants # =>

  def as_json(options = {})
    super(options.merge(include: [:items, participants: { methods: [:name, :color] }]))
  end
end
