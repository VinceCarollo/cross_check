# require 'csv'
# p CSV.read('./data/game.csv')
require 'csv'

tracker = {}

#sets first line of csv (headers) to keys of 'tracker' hash
CSV.readlines('./data/game.csv')[0].each do |header|
  tracker[header.to_sym] = []
end

#pushes all matching data of keys into tacker values
CSV.foreach('./data/game.csv', {:headers => true, :header_converters => :symbol}) do |row|
  tracker.map do |type, data|
    data << row[type]
  end
end
