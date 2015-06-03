# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!( :username => "admin123", :role_id=> 1 ,:re_password => 'admin123',
              :name =>'admin', :state=>'Y' ,:password=>'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918' ,
              :email =>"nvizero@yahoo.com.tw" , :forget_pas=>'admin123')

User.create!( :username => "nvizero", :role_id=> 1 ,:re_password => 'nvizero',
              :name =>'nvizero', :state=>'Y' ,:password=>'5836606da0b5639f4e0fb03747c5ef7a9821425dc1002d641f743aca8488487e' ,
              :email =>"withvictor@gmail.com" , :forget_pas=>'nvizero')


Msg.create!( :title => "關於我們", :content => '關於我們＿' , :state=>'Y' , :place=>'top')
Msg.create!( :title => "服務項目", :content => '服務項目＿' , :state=>'Y' , :place=>'top')
Msg.create!( :title => "三證說明", :content => '三證說明＿' , :state=>'Y' , :place=>'top')

VerifyTypeMain.create!( :title => "食品", :content => '' , :state=>'Y' )
VerifyTypeMain.create!( :title => "化裝品", :content => '' , :state=>'Y')
