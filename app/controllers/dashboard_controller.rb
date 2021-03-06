class DashboardController < ApplicationController

  layout "admin"

  #before_action :confirm_logged_in
  # before_action :get_base_data

  #取得一些基本資訊
  before_action :get_base_data


  def index

    first_msg = Msg.first
    @title = ['main1'=>'首頁' , 'main2'=>'index','sub1'=>'首頁' , 'sub2'=>'index']
    #@title = ['main1' => @msg.first, 'main2'=>'','sub1'=>'首頁' , 'sub2'=>first_msg.title]
    @msg = first_msg
    @users = User.all.count


  end

  def main
    
    # render :text => session[:user["access"]]
    self.confirm_logged_in
    @title = ['main1'=>'看板管理', 'main2'=>'Dashboard','sub1'=>'首頁' , 'sub2'=>'看板管理']
    @msgs = Msg.all
    @users = User.all
    @products = Product.all
  end
end
