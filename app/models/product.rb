class Product < ActiveRecord::Base

  paginates_per 10
  belongs_to :user
  belongs_to :verify_type_main
  has_many :product_in_outs

  has_many   :product_verifies

  scope :live , lambda { where("products.state = 'Y' ") }
  scope :stoped  , lambda { where("products.state = 'N' ") }

  validates :title,        :presence => { :message => "產品名稱－不能空白" }
  validates :code,        :presence => { :message => "料品編號－不能空白" },
                          :uniqueness => { :message => "料品編號－是唯一值,請重新輸入" }
                          
  validates :user_id,      :presence => { :message => "使用者－不能空白" }
  validates :specification,      :presence => { :message => "規格－不能空白" }

  before_create do
    self.state = "Y"
  end
  # (:title, :content, :num, :user_id)

end
