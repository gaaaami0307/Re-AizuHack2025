class Input < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :emotion, :maxtime, presence: true
end