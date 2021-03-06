require 'csv'
require_relative './games'
require_relative './teams'
require_relative './game_teams'

class Breakdown


  def self.read_games(path)
    tracker = []

    CSV.foreach(path, {:headers => true, :header_converters => :symbol}) do |row|
      tracker << Games.new(row)
    end
    tracker
  end

  def self.read_teams(path)
    tracker = []

    CSV.foreach(path, {:headers => true, :header_converters => :symbol}) do |row|
      tracker << Teams.new(row)
    end
    tracker
  end

  def self.read_game_teams(path)
    tracker = []

    CSV.foreach(path, {:headers => true, :header_converters => :symbol}) do |row|
      tracker << GameTeams.new(row)
    end
    tracker
  end
end
