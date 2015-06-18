class InOutType < ActiveRecord::Base
    paginates_per 10
    
    scope :live, lambda { where("in_out_types.state = 'Y' ") }
    scope :stoped  , lambda { where("in_out_types.state = 'N' ") }


end
