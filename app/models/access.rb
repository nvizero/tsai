class Access < ActiveRecord::Base
  paginates_per 12
  scope :stoped  , lambda { where("accesses.state = 'N' ") }
  scope :live, lambda { where("accesses.state = 'Y' ") }
  validates :title,  :presence => { :message => "名稱－不能空白" }
  validates :code,   :presence => { :message => "代碼－不能空白" },
                     :uniqueness => { :message => "是唯一值－有重複,請重新輸入" }
  before_create do
    self.state = "Y"
  end
  
end
