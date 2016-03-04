class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      @items.push TodoItem.new(description, options)
    elsif type == "event"
      @items.push EventItem.new(description, options)
    elsif type == "link"
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType, "#{type} not supported."
    end
    priority = options[:priority]
    if priority && !(["high", "medium", "low"].include? priority)
      raise UdaciListErrors::InvalidPriorityValue,  "#{priority} invalid priority type." 
    end
  end

  def delete(index)
    if index  > @items.length
      raise UdaciListErrors::IndexExceedsListSize, "#{index} out of range."
    else
      @items.delete_at(index - 1)
    end
  end
  def give_title
    if @title
      return @title
    else
      @title = "Untitled List"
      return @title
    end
  end
  def all
    puts "-" * give_title.length
    puts @title
    puts "-" * give_title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
