class Msg < ActiveRecord::Base

  scope :live, lambda { where("msgs.state = 'Y' ") }

end
