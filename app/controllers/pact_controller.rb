class PactController < ApplicationController

  def post_username
    @user = User.first
    # puts response.body
    # respond_with(:json, render :text => "Successfully Done!")
    # render :text => "hello world!"
    render :text => "Hello", :content_type => Mime::TEXT
  end

end
