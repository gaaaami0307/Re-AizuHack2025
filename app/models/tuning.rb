class Tuning < ApplicationRecord
  validates :ep, presence: true, uniqueness: true, inclusion: { in: 1..5}
  validates :T, :M, :C, presence: true
end
