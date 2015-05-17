class DashboardController < ApplicationController

  layout "admin"

  #before_action :confirm_logged_in
  before_action :get_base_data
  #取得一些基本資訊
  before_action :get_base_data


  def index



    @title = ['main1'=>'首頁', 'main2'=>'index','sub1'=>'首頁' , 'sub2'=>'index']
    @msgs = Msg.all
    @users = User.all.count
  end

  def main
    
    self.confirm_logged_in
    @title = ['main1'=>'看板管理', 'main2'=>'Dashboard','sub1'=>'首頁' , 'sub2'=>'看板管理']
    @msgs = Msg.all
    @users = User.all.count
  end
end
