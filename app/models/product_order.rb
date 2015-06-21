class ProductOrder < ActiveRecord::Base

  paginates_per 10

  belongs_to :member
  belongs_to :order_state

  scope :stoped  , lambda { where("product_orders.state = 'N' ") }
  scope :live, lambda { where("product_orders.state = 'Y' ") }

  validates :member_id,        :presence => { :message => "訂購者－不能為空" }



  before_create do
    self.state = "Y"
  end
end
