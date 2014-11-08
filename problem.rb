#!/usr/bin/env ruby

require 'gruff'

class Problem
  # start with example
  
  # y' = sin(yt) 
  def calculate y, t
    1 - t*y
  end

  def step y, t, h
    k1 = calculate(y,t)
    k2 = calculate(y + 0.5*h*k1, t+0.5*h)
    k3 = calculate(y + 0.5*h*k2, t+0.5*h)
    k4 = calculate(y + h*k3, t+h)

    #puts "k1: f(#{t},#{y})=#{k1}"
    #puts "k2: f(#{t+0.5*h},#{y+0.5*h*k1})=#{k2}" 
    #puts "k3: f(#{t+0.5*h},#{y+0.5*h*k2})=#{k3}"
    #puts "k4: f(#{t+h},#{y+h*k3})=#{k4}"
 
    y + (h*(k1 + 2*k2 + 2*k3 +k4))/6
  end

end

initial_y = 1
initial_t = 0
step_size = 0.01

yvalues = [initial_y]

problem = Problem.new

10000.times do |step|
  current_time = initial_t + step_size * step
  #puts "curent time _#{current_time}"
  calculated_y = problem.step(yvalues.last, current_time, step_size)
  #puts "step #{step}, time: #{current_time}, y: #{calculated_y}"
  yvalues << calculated_y
end

require 'gruff'
g = Gruff::Line.new
g.title = 'Runge Kutta 4 for y\'(t)=1-yt'

g.data :RK4, yvalues

g.write('solution.png')

def write_data
  File.open("plotme", "w+") do |f|
    f.puts(yvalues)
  end
end
