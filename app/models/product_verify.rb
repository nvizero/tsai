class ProductVerify < ActiveRecord::Base

  paginates_per 12
  belongs_to   :product
  belongs_to   :product_verify_type
  belongs_to   :product_verify_state

  has_many   :product_verify_contents
  # def products
  #
  # end
  scope :stoped  , lambda { where("product_verifies.state = 'N' ") }
  scope :live, lambda { where("product_verifies.state = 'Y' ") }
  before_create do
    self.state = "Y"
  end
end
