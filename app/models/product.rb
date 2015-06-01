class Product < ActiveRecord::Base

  paginates_per 10
  belongs_to :user
  has_many   :product_verifies


  validates :title,        :presence => { :message => "產品名稱－不能空白" }
  validates :content,      :presence => { :message => "產品內容－不能空白" }
  validates :user_id,      :presence => { :message => "使用者－不能空白" }
  before_create do
    self.state = "Y"
  end
  # (:title, :content, :num, :user_id)

end
