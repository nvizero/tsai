class Daily < ActiveRecord::Base

  paginates_per 10

  scope :live, lambda { where("dailies.state = 'Y' ") }
  scope :stoped  , lambda { where("dailies.state = 'N' ") }

  before_create do
    self.state = "Y"
  end

end
