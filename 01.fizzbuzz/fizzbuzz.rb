#!/usr/bin/env ruby
# frozen_string_literal: true

def fizzbuzz(num)
  if (num % 15).zero?
    'FizzBuzz'
  elsif (num % 3).zero?
    'Fizz'
  elsif (num % 5).zero?
    'Buzz'
  else
    num.to_s
  end
end

(1..20).each do |n|
  puts fizzbuzz(n)
end
