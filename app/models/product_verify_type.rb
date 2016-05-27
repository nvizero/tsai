class ProductVerifyType < ActiveRecord::Base
  # belongs_to :product_verify


  belongs_to :verify_type_main

  # has_many :product_verify
  scope :live, lambda { where("product_verify_types.state = 'Y' ") }
  scope :stoped  , lambda { where("product_verify_types.state = 'N' ") }
  before_create do
    self.state = "Y"
  end
end
