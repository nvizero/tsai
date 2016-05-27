namespace :user do
     desc "describe your rake描述你的rake"
     task :task_name => :environment do
        every 1.hours do
            rake "jobs:sandy"
        end
     end
 end
