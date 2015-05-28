class ProductVerify < ActiveRecord::Base

  belongs_to   :products
  belongs_to   :product_verify_type
  # has_many   :product_verify_type

end
