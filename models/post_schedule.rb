class PostSchedule < ActiveRecord::Base
  #Class_name: "Post", foreign_key: :post_id 생략가능
  belongs_to :post, class_name: "Post", foreign_key: :post_id

  def self.year_schedules(year)
    self.schedules(Date.new(year).beginning_of_year.next_year, Date.new(year).beginning_of_year)
  end

  def self.month_schedules(year, month)
    self.schedules(Date.new(year, month).beginning_of_month.next_month, Date.new(year, month).beginning_of_month)
  end

  def self.day_schedules(year, month, day)
    self.schedules(Date.new(year, month, day).next_day, Date.new(year, month, day))
  end

  private

  def self.schedules(start_param, end_param)
    self.where("start_date < ?", start_param).where("end_date >= ?", end_param)
  end
end