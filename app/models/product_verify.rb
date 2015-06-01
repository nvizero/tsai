class ProductVerify < ActiveRecord::Base

  paginates_per 10
  belongs_to   :product
  belongs_to   :product_verify_type
  # has_many   :product_verify_type
  # def products
  #
  # end
  before_create do
    self.state = "Y"
  end
end
