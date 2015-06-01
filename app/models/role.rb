class Role < ActiveRecord::Base
  paginates_per 5
  #.permit(:title, :text)
  validates :title,  :presence => { :message => "角色名稱－不能空白" } ,
                     :uniqueness => { :message => "角色名稱－有重複,請重新輸入" }

  validates :text,  :presence => { :message => "角色說明－不能空白" } ,
                    :uniqueness => { :message => "角色名稱－有重複,請重新輸入" }
  # belongs_to :user
  scope :live, lambda { where("roles.state = 'Y' ") }

  before_create do
    self.state = "Y"
  end
end
