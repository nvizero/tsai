class RollsController < ApplicationController




  def delete
    reset_session
    session.clear
    redirect_to :controller =>'dashboard' , :action=>'index'
  end


  def sign_out
    reset_session
    session.clear
    redirect_to :controller =>'dashboard' , :action=>'index'
  end
end
