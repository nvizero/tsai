class LoginController < ApplicationController


  def do_login
    #eeee
    @mail = params[:email].rstrip
    @old = params[:password].rstrip
    @check_pas    = Digest::SHA256.hexdigest @old.rstrip.to_s
    @password = @check_pas
    @is_login = User.where(:email=>@mail , :password => @check_pas ).first

    #rebder 'login/do_login'
  end

end
