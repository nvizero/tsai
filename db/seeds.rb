# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!( :username => "nvizero", :role_id=> 1 ,:re_password => '123456',
              :name =>'nvizero', :state=>'Y' ,:password=>'123456' ,
              :email =>"withvictor@gmail.com" , :forget_pas=>'123456')

Msg.create!( :title => "關於我們", :content => '關於我們＿' , :state=>'Y' , :place=>'top')
Msg.create!( :title => "服務項目", :content => '服務項目＿' , :state=>'Y' , :place=>'top')
Msg.create!( :title => "三證說明", :content => '三證說明＿' , :state=>'Y' , :place=>'top')

VerifyTypeMain.create!( :title => "食品", :content => '' , :state=>'Y' )
VerifyTypeMain.create!( :title => "化裝品", :content => '' , :state=>'Y')
