class VerifyTypeMain < ActiveRecord::Base


  paginates_per 5
  has_many :product_verify_types
  has_many :product


  scope :live, lambda { where(" verify_type_mains.state = 'Y' ") }
  scope :stoped  , lambda { where("verify_type_mains.state = 'N' ") }

  validates :title,  :presence => { :message => "名稱 不能空白" }

  # after_save :state_to_Y
  #
  # def state_to_Y
  #   # state='Y'
  #   # save
  #   # update_attributes(:state => 'Y')
  #   self.state = 'Y'
  #   save
  # end

  before_create do
    self.state = "Y"
  end

end
