require 'pry'
require_relative './breakdown'
require_relative './game_stats'

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

  def highest_total_score
    stats = GameStats.new(self.games)
    stats.highest_total_score
  end

  def lowest_total_score
    stats = GameStats.new(self.games)
    stats.lowest_total_score
  end

  def biggest_blowout
    stats = GameStats.new(self.games)
    stats.biggest_blowout
  end

  def percentage_home_wins(home_team_id)
    stats = GameStats.new(self.games)
    stats.percentage_home_wins(home_team_id)
  end

  def percentage_visitor_wins(away_team_id)
    stats = GameStats.new(self.games)
    stats.percentage_visitor_wins(away_team_id)
  end

  def count_of_games_by_season(season)
    stats = GameStats.new(self.games)
    stats.count_of_games_by_season(season)
  end

  def average_goals_per_game
    stats = GameStats.new(self.games)
    stats.average_goals_per_game
  end

end
