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

  def percentage_home_wins
    games_played = 0
    games_won = 0
    self.games.each do |game|

      games_played += 1
      if game.outcome.include?("home") && game.outcome.include?("win")
        games_won += 1
      end
    end
    (games_won.to_f / games_played).round(2)
  end

  def percentage_visitor_wins
    games_played = 0
    games_won = 0
    self.games.each do |game|

      games_played += 1
      if game.outcome.include?("away") && game.outcome.include?("win")
        games_won += 1
      end
    end
    (games_won.to_f / games_played).round(2)
  end

  def count_of_games_by_season
    seasons = self.games.group_by do |game|
      game.season
    end

    seasons.transform_values do |games|
      games.count
    end
  end

  def average_goals_per_game
    game_count = 0
    goals = self.games.sum do |game|
      game_count += 1
      game.away_goals + game.home_goals
    end
    (goals / game_count.to_f).round(2)
  end

  def average_goals_by_season

    games_by_season = self.games.group_by do |game|
       game.season
    end

    games_by_season.transform_values do |games_per_season|
      total_goals = games_per_season.sum do |game|
        game.home_goals + game.away_goals.to_f
      end
      (total_goals / games_per_season.length).round(2)
    end
  end

end
