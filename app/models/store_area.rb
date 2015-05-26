class StoreArea < ActiveRecord::Base

  paginates_per 10

  validates :area_id,  :presence => { :message => "庫位代碼－不能空白" } ,
                  :length => {:minimum => 1, :maximum => 8, :message => "庫位代碼－最多輸入8碼" } ,
                  :uniqueness => { :message => "庫位代碼－是唯一值－有重複,請重新輸入" }
  validates :area_name,  :presence => { :message => "庫位說明－不能空白" },
            :length => {:minimum => 1, :maximum => 8, :message => "庫位名稱－最多輸入8個字元" }  

end
