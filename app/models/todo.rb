class Todo < ActiveRecord::Base
  belongs_to :user

  def to_pleasant_string
    is_completed = completed ? "[x]" : "[ ]"
    "[#{id}]. #{due_date.to_s(:short)} #{todo_text}  #{is_completed}"
  end

  def due_today?
    due_date == Date.today
  end

  def self.overdue
    where("due_date < ? and (not completed)", Date.today).order(:due_date)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

  def self.mark_as_complete(id)
    to_mark = Todo.find(id)
    to_mark.completed = true
    to_mark.save
    to_mark
  end
end
