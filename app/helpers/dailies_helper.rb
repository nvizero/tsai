module DailiesHelper

  def match_day all_data , match_day_obj

      day_s = ""
      all_data.each do |this_day|

          if this_day.day.to_s == match_day_obj.to_s
            
              day_s +=  '<a href="/dailies/'+ "#{this_day.id}" + '"' + '>'+
                        " #{this_day.day_type}-#{this_day.title}"+
                        "</a>"+
                        "<br>"
          end

      end

      return day_s
  end

end
