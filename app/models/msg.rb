class Msg < ActiveRecord::Base
  paginates_per 10

  scope :live, lambda { where("msgs.state = 'Y' ") }
  scope :top, lambda { where("msgs.place = 'top' ") }
  scope :mid, lambda { where("msgs.place = 'mid' ") }

  # :title, :content, :state ,:place
  validates :title,  :presence => { :message => "名稱－不能空白" } ,
                  :uniqueness => { :message => "名稱－有重複,請重新輸入!!" }

  validates :content,  :presence => { :message => "內容－不能空白" }
  before_create do
    self.state = "Y"
  end
end
