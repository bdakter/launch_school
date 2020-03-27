#! /usr/bin/env ruby

class Todo
  DONE_MARKER = 'X'
  NOT_DONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = NOT_DONE_MARKER
  end

  def done!
    self.done = DONE_MARKER
  end

  def not_done!
    self.done = NOT_DONE_MARKER
  end

  def done?
    done == DONE_MARKER
  end

  def to_s
    "[#{done}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, 'Can only add Todo objects' unless todo.instance_of? Todo

    todos << todo
    todos
  end

  alias << add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all?(&:done?)
  end

  def item_at(index)
    todos.fetch index
  end

  def mark_done_at(index)
    todos.fetch(index).done!
  end

  def mark_undone_at(index)
    todos.fetch(index).not_done!
  end

  def done!
    todos.each(&:done!)
  end

  def to_s
    text = "------ Today's Todos ------\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    todos.delete_at(index)
  end

  def each
    todos.each do |todo|
      yield todo
    end

    self
  end

  def select
    temp = TodoList.new(title)

    each do |todo|
      temp.add(todo) if yield todo
    end
    temp
  end

  def find_by_title(str)
    todos.detect do |todo|
      todo.title.downcase == str.downcase
    end
  end

  def all_dones
    select(&:done?)
  end

  def all_not_dones
    select do |todo|
      !todo.done?
    end
  end

  def mark_done(item)
    find_by_title(item).done!
  end

  def mark_all_done
    each(&:done!)
  end

  def mark_all_not_done
    each(not_done!)
  end

  private

  attr_accessor :todos
end
