class ProductVerify < ActiveRecord::Base

  belongs_to   :product
  belongs_to   :product_verify_type
  # has_many   :product_verify_type
  # def products
  #
  # end
end
