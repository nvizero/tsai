class ProductVerify < ActiveRecord::Base

  paginates_per 2
  belongs_to   :product
  belongs_to   :product_verify_type
  # has_many   :product_verify_type
  # def products
  #
  # end
  scope :stoped  , lambda { where("product_verifies.state = 'N' ") }
  scope :live, lambda { where("product_verifies.state = 'Y' ") }
  before_create do
    self.state = "Y"
  end
end
