class ProductVerifyType < ActiveRecord::Base
  # belongs_to :product_verify
  has_many :product_verify
  before_create do
    self.state = "Y"
  end
end
