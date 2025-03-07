#!/usr/bin/env ruby
# frozen_string_literal: true

require 'colorize'
require 'date'
require 'optparse'

DAY_WIDTH = 2
DOW = "日 月 火 水 木 金 土\n"

opt = OptionParser.new
params = {}

opt.on('-m VAL') { |v| params[:month] = v.to_i }
opt.on('-y VAL') { |v| params[:year] = v.to_i }
opt.parse!(ARGV)

# 引数が渡されなかった際に当年当月を格納する
params[:month] ||= Date.today.month
params[:year] ||= Date.today.year

def header(month, year)
  res = "#{month}月 #{year}".center((DAY_WIDTH + 1) * 7)
  res << "\n"
end

# カレンダーのコンテンツ領域を作成する
def cal_content(month, year)
  first_date = Date.new(year, month, 1)
  last_date = Date.new(year, month, -1)

  res = ' ' * first_date.wday * (DAY_WIDTH + 1)
  (first_date..last_date).each do |date|
    tmp = date.day.to_s.rjust(DAY_WIDTH)
    res += date == Date.today ? tmp.colorize(color: :black, background: :white) : tmp
    res += date.saturday? ? "\n" : ' '
  end

  res
end

def render(month, year)
  result = header(month, year) + DOW + cal_content(month, year)
  puts result
end

render(params[:month], params[:year])
