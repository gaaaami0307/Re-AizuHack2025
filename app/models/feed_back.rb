class FeedBack < ApplicationRecord
  validates :ep, presence: true, inclusion: { in: 1..5}
  validates :date, presence: true, uniqueness: true
  validates :tf, :con, :mtv, presence: true
end
