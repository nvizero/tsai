require 'clockwork'
require 'delayed_job'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end
  every(5.seconds, "check_auction_times加入排程" ) {
    # Base::ApplicationController.new.delay.whtest
    # uu = User.find(2)
    # UserMailer.new_user(uu).deliver
  }
end
