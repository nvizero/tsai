class ProductVerifyState < ActiveRecord::Base

  paginates_per 10

  scope :live , lambda { where("product_verify_states.state = 'Y' ") }
  scope :stoped  , lambda { where("product_verify_states.state = 'N' ") }


  validates :title,  :presence => { :message => "名稱－不能空白" } ,
                  :uniqueness => { :message => "名稱－有重複,請重新輸入!!" }

end
