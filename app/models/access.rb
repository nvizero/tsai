class Access < ActiveRecord::Base
  paginates_per 5

  validates :title,  :presence => { :message => "名稱－不能空白" }
  validates :code,   :presence => { :message => "代碼－不能空白" } 
end
