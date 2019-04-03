require 'pry'
class GameStats
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_total_score
    goals = @games.map do |game|
      game.away_goals + game.home_goals
    end
    goals.max
  end

  def lowest_total_score
    goals = @games.map do |game|
      game.away_goals + game.home_goals
    end
    goals.min
  end

  def biggest_blowout
    goals = @games.map do |game|
      if game.outcome.include?("home")
        game.home_goals - game.away_goals
      elsif game.outcome.include?("away")
        game.away_goals - game.home_goals
      end
    end
    goals.max
  end
end
