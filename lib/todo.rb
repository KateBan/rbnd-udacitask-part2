
class TodoItem
  include Listable
  attr_reader :description, :due
  attr_accessor :priority
  def initialize(description,options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]      
    @priority = options[:priority]
    
  end

  def details
    format_description("To do", @description) + "due: " +
    format_date(due: @due) +
    format_priority(@priority)
  end
end
