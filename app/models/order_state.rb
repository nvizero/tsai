class OrderState < ActiveRecord::Base
  paginates_per 10

  scope :stoped  , lambda { where("order_states.state = 'N' ") }
  scope :live, lambda { where("order_states.state = 'Y' ") }
  validates :title,  :presence => { :message => "狀態名稱－不能空白" }

  before_create do
    self.state = "Y"
  end

end
