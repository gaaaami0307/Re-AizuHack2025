class Plan < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :num, :time, presence: true
end
