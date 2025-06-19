class Task < ApplicationRecord
  validates :date, presence: true
end
