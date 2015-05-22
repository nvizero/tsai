class PactController < ApplicationController


  skip_before_action :verify_authenticity_token

  def post_username

    user = User.where(:username=>params['username']).first

    if user
        render :text => user.forget_pas
    else
        render :text => false
    end

  end

end
