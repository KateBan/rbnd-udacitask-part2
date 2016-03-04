class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    allowed_types = { todo: TodoItem, link: LinkItem, event: EventItem }
    if allowed_types.keys.include? type.to_sym
      @items.push allowed_types[type.to_sym].new(description, options)
    else
      raise UdaciListErrors::InvalidItemType, "#{type} not supported."
    end
    priority = options[:priority]
    if priority && !(["high", "medium", "low"].include? priority)
      raise UdaciListErrors::InvalidPriorityValue,  "#{priority} invalid priority type." 
    end
  end

  def delete(*index)
      check_list = [*index]
      check_list.each do |i|
        if i > @items.length
          raise UdaciListErrors::IndexExceedsListSize, "#{i} out of range."
        end
      end
      @items.delete_if.with_index {|_, index| check_list.include? index + 1}
  
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
      filtered_items = items.select {|item| item.is_a?(TodoItem)}
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
  def find_item(index)
    @items[index - 1]
  end
end

 