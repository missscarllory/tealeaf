module Towable
  def can_tow?(pounds)
    pounds < 1500 ? true:false
  end
end

class Vehicle
  @@number_of_vehicles = 0
  
  attr_accessor :color
  attr_reader :year
  attr_reader :model
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles/gallons} miles per gallon of gas."
  end
  
  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end
  
  def speed_up(num)
    @current_speed += num
    puts "You push the gas and accelerate #{num} mph."
  end

  def brake(num)
    @current_speed -= num
    puts "You push the brake and decelerate #{num} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park the car."
  end

  def spray_paint(color)
    self.color = color
    puts "Your new color of BMW is #{color}"
  end

  def age
    "Your #{self.model} is #{year_old} years old."
  end
  
  private
  
  def year_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year}, #{model}!"
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.color}, #{self.year}, #{model}!"
  end
end


puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

MyCar.gas_mileage(13, 169)
car = MyCar.new(1996, "red", "BMW")
puts car.age
car1 = MyCar.new(1996, "red", "BMW")
truck = MyTruck.new(1937, "black", "Toyota")
puts car
puts truck

puts Vehicle.number_of_vehicles
puts truck.can_tow?(300)

#protected exercise
class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 80)

puts "Well done!" if joe.better_grade_than?(bob)
