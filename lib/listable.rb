#!/usr/bin/env ruby -w
# encoding: UTF-8

module Listable
  # Listable methods go here
  def format_description(description)
  	"#{description}".ljust(30)
  end

 def format_date(options = {})
 	@start_date = options[:start_date]
 	@end_date = options[:end_date]
 	@due = options[:due]
    if @due
      dates = @due.strftime("%D")
    elsif @start_date
      dates = @start_date.strftime("%D")
      if @end_date 
        dates << " -- " +  @end_date.strftime("%D")
      end
    else
      dates = "No date provided"
    end
    return dates
  end

   def format_priority(priority)
     if @priority == "high"
      value = " ⇧"
     elsif @priority == "medium"
      value = " ⇨" 
     elsif @priority == "low"
      value = " ⇩"
     elsif !@priority
      value = ""
    else
      raise UdaciListErrors::InvalidPriorityValue, "#{priority} invalid value"  
    end
    return value
  end
end
