class Emotion < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :positive, :neutral, :negative, presence: true
end
