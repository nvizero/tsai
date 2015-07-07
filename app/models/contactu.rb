class Contactu < ActiveRecord::Base

  paginates_per 10
  validates :title,     :presence => { :message => "名稱－不能空白" }
  validates :content,   :presence => { :message => "代碼－不能空白" }
  validates :email, :presence => { :message => "E-mail 不能空白" },
  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create   , :message => "格式錯誤" }
end
