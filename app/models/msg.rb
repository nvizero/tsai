class Msg < ActiveRecord::Base
  paginates_per 5

  scope :live, lambda { where("msgs.state = 'Y' ") }
  scope :top, lambda { where("msgs.place = 'top' ") }
  scope :mid, lambda { where("msgs.place = 'mid' ") }

end
