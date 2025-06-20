class Plan < ApplicationRecord
  validates :ep, presence: true, inclusion: { in: 1..5}
  validates :date, presence: true, uniqueness: true
  validates :num, :time, presence: true
end
