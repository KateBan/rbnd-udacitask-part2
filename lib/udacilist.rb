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
  def filter(type)
    filtered_items = []
    if type == "todo"
      filtered_items = items.selsect {|item| item.is_a?(TodoItem)}
    elsif type == "event"
      filtered_items = items.select {|item| item.is_a?(EventItem)}
    elsif type == "link"
      filtered_items = items.select {|item| item.is_a?(LinkItem)}
    else
      puts "There aren't any itmes with type ", "#{type}"
    end
    table = filter_for_table(filtered_items)
    puts table
  end

  def filter_for_table(list)
    rows = []
    list.each_with_index do |item, position|
      rows << [position + 1, item.details]
    end
    Terminal::Table.new :title => give_title,
    :headings => ["Num", "Type   Name                   Details"],
    :rows => rows
  end

  def all
    table = filter_for_table(@items)
    puts table
  end
end

 