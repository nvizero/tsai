class Trade < ActiveRecord::Base

  # belongs_to :user
  has_one :user

  scope :sorted, lambda { order("trades.id ASC") }
end
