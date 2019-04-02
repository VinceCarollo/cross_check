# Create a class method call from_csv
require 'csv'
require 'pry'
require './lib/breakdown'
# require './lib/module'

class StatTracker

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    # @games = CSV.read(locations[:games])
    # @teams = locations[:teams]
    # @game_teams = locations[:game_teams]
    games = {}
    teams = {}
    game_teams = {}

    locations.each do |name, path|
      if name == :games
        games = Breakdown.read(path)
      elsif name == :teams
        teams = Breakdown.read(path)
        # binding.pry
      elsif name == :game_teams
        game_teams = Breakdown.read(path)
      end
    end
    stat_tracker = StatTracker.new(games, teams, game_teams)
    stat_tracker
  end
end
