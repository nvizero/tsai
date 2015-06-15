class ProductInOut < ActiveRecord::Base
  paginates_per 10
  belongs_to :product

  scope :in_come  , lambda { where("product_in_outs.in_or_out = 'in' ") }
  scope :out_come  , lambda { where("product_in_outs.in_or_out = 'out' ") }

  scope :live  , lambda { where("product_in_outs.state = 'Y' ") }
  scope :stoped  , lambda { where("product_in_outs.state = 'N' ") }

end
