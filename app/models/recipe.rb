class Recipe < ApplicationRecord
  default_scope -> { order(updated_at: :desc) }

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
end
