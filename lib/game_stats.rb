require 'pry'

module GameStats

  def highest_total_score
    goals = self.games.map do |game|
      game.away_goals + game.home_goals
    end
    goals.max
  end

  def lowest_total_score
    goals = self.games.map do |game|
      game.away_goals + game.home_goals
    end
    goals.min
  end

  def biggest_blowout
    goals = self.games.map do |game|
      if game.outcome.include?("home")
        game.home_goals - game.away_goals
      elsif game.outcome.include?("away")
        game.away_goals - game.home_goals
      end
    end
    goals.max
  end

  def percentage_home_wins(home_team_id)
    games_played = 0
    games_won = 0
    self.games.each do |game|
      if game.home_team_id == home_team_id
        games_played += 1
        games_won += 1 if game.outcome.include?("home")
      end
    end
    ((games_won.to_f / games_played) * 100).round(2)
  end

  def percentage_visitor_wins(away_team_id)
    games_played = 0
    games_won = 0
    self.games.each do |game|
      if game.away_team_id == away_team_id
        games_played += 1
        games_won += 1 if game.outcome.include?("away")
      end
    end
    ((games_won.to_f / games_played) * 100).round(2)
  end

  def count_of_games_by_season(season)
    result = {}
    result[season] = 0
    self.games.each do |game|
      if game.season == season
        result[season] += 1
      end
    end
    result
  end

  def average_goals_per_game
    game_count = 0
    goals = self.games.sum do |game|
      game_count += 1
      game.away_goals + game.home_goals
    end
    (goals / game_count.to_f).round(2)
  end

end
