class PayType < ActiveRecord::Base

    paginates_per 10


      scope :live, lambda { where("pay_types.state = 'Y' ") }
      scope :stoped  , lambda { where("pay_types.state = 'N' ") }


      # :title, :content, :state ,:place
      validates :code,  :presence => { :code => "名稱－不能空白" } ,
                      :uniqueness => { :code => "名稱－有重複,請重新輸入!!" }

      validates :content,  :presence => { :content => "內容－不能空白" }



    before_create do
      self.state = "Y"
    end
end
