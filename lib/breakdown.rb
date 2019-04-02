require 'csv'

class Breakdown

  def self.read(path)
    tracker = {}

    #sets first line of csv (headers) to keys of 'tracker' hash
    CSV.readlines(path)[0].each do |header|
      tracker[header.to_sym.downcase] = []
    end

    #pushes all matching data of keys into tacker values
    CSV.foreach(path, {:headers => true, :header_converters => :symbol}) do |row|
      tracker.map do |type, data|
        data << row[type]
      end
    end
    tracker
  end
end
