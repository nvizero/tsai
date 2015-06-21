class Member < ActiveRecord::Base

  paginates_per 10



  scope :stoped  , lambda { where("members.state = 'N' ") }
  scope :live, lambda { where("members.state = 'Y' ") }

  validates :name,      :presence => { :message => "性名－不能空白" }
  validates :tel,       :presence => { :message => "電話－不能空白" }
  validates :address,   :presence => { :message => "住址－不能空白" }

  before_create do
    self.state = "Y"
  end


end
