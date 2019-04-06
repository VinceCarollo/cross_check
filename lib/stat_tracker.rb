require 'pry'
require_relative './breakdown'
require_relative './game_stats'
require_relative './league_stats'

class StatTracker
  include GameStats
  include LeagueStats

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = {}
    teams = {}
    game_teams = {}

    locations.each do |name, path|
      if name == :games
        games = Breakdown.read_games(path)
      elsif name == :teams
        teams = Breakdown.read_teams(path)
      elsif name == :game_teams
        game_teams = Breakdown.read_game_teams(path)
      end

    end
    StatTracker.new(games, teams, game_teams)
  end
end
