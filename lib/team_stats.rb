require 'pry'

module TeamStats

  def team_info(num_arg)
    info = {}
    self.teams.each do |team|
      if team.team_id == num_arg
        info = {
          "abbreviation" => team.abbreviation,
          "franchise_id" => team.franchise_id,
          "link" => team.link,
          "short_name" => team.short_name,
          "team_id" => team.team_id,
          "team_name" => team.team_name
        }
      end
    end
  info
  end

  def best_season(team_id)
    team_id_array = self.game_teams.select do |game|
      game.team_id == team_id
    end

    games_by_season = team_id_array.group_by do |game|
      game.game_id[0..3]
    end

    games_played = 0
    games_won = 0
    best_game_id = games_by_season.transform_values do |games|
      games.each do |game|
        games_played += 1
        if game.won == "TRUE"
          games_won += 1
        end
      end
      (games_won / games_played.to_f)
    end

    b_season = best_game_id.max_by do |season, ratio|
      ratio
    end[0]

    final_return = self.games.find do |game|
      game.season[0..3].include?(b_season)
    end.season
    final_return
  end

  def worst_season(team_id)
    team_id_array = self.game_teams.select do |game|
      game.team_id == team_id
    end

    games_by_season = team_id_array.group_by do |game|
        game.game_id[0..3]
    end

    games_played = 0
    games_lost = 0
    worst_game_id = games_by_season.transform_values do |games|
      games.each do |game|
        games_played += 1
        if game.won == "FALSE"
          games_lost += 1
        end
      end
      (games_lost / games_played.to_f)
    end

    w_season = worst_game_id.max_by do |season, ratio|
      ratio
    end[0]

    final_return = self.games.find do |game|
      game.season[0..3].include?(w_season)
    end.season
    final_return
  end

  def average_win_percentage(team_id)
    games_played = 0
    games_won = 0
    self.game_teams.each do |game|
      if game.team_id == team_id
          games_played += 1
        if game.won == "TRUE"
          games_won += 1
        end
      end
    end
      (games_won / games_played.to_f).round(2)
  end

  def most_goals_scored(team_id)
    game_array = self.game_teams.find_all do |game|
      game.team_id == team_id
    end

    game_array.max_by do |game|
      game.goals
    end.goals
  end

  def fewest_goals_scored(team_id)
    game_array = self.game_teams.find_all do |game|
      game.team_id == team_id
    end
    game_array.min_by do |game|
      game.goals
    end.goals
  end

  def favorite_opponent(team_id)
    games_played = self.games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
    away_played = []
    home_played = []

    games_played.each do |game|
      if game.home_team_id == team_id
        away_played << game
      else
        home_played << game
      end
    end

    away_played_against = away_played.group_by{|game| game.away_team_id}
    home_played_against = home_played.group_by{|game| game.home_team_id}
    teams_played_against = away_played_against.merge(home_played_against){|k, n, o| n + o}

    ratios = {}
    teams_played_against.each do |game_team_id, games|
      games_played = 0
      games_won = 0
      games.each do |game|
        games_played += 1
        if game.home_team_id == game_team_id
          games_won += 1 if game.outcome.include?("win") && game.outcome.include?("home")
        else
          games_won += 1 if game.outcome.include?("win") && game.outcome.include?("away")
        end
      end
      ratios[game_team_id] = games_won / games_played.to_f
    end
    fav_opponent = ratios.min_by{|game_team_id, ratio| ratio}[0]
    self.teams.find{|team| team.team_id == fav_opponent}.team_name
  end

  def rival(team_id)
    games_played = self.games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
    away_played = []
    home_played = []

    games_played.each do |game|
      if game.home_team_id == team_id
        away_played << game
      else
        home_played << game
      end
    end

    away_played_against = away_played.group_by{|game| game.away_team_id}
    home_played_against = home_played.group_by{|game| game.home_team_id}
    # binding.pry
    teams_played_against = away_played_against.merge(home_played_against){|k, n, o| n + o}
    ratios = {}
    teams_played_against.each do |game_team_id, games|
      games_played = 0
      games_won = 0
      games.each do |game|
        games_played += 1
        if game.home_team_id == game_team_id
          games_won += 1 if game.outcome.include?("win") && game.outcome.include?("home")
        else
          games_won += 1 if game.outcome.include?("win") && game.outcome.include?("away")
        end
      end
      ratios[game_team_id] = games_won / games_played.to_f
    end
    rival_id = ratios.max_by{|game_team_id, ratio| ratio}[0]
    self.teams.find{|team| team.team_id == rival_id}.team_name
  end

  def biggest_team_blowout(team_id)
    differences = []
    self.games.each do |game|
      if game.home_team_id == team_id
        if game.outcome.include?('home') && game.outcome.include?('win')
          differences << game.home_goals - game.away_goals
        end
      elsif game.away_team_id == team_id
        if game.outcome.include?('away') && game.outcome.include?('win')
          differences << game.away_goals - game.home_goals
        end
      end
    end
    differences.max
  end

  def worst_loss(team_id)
    differences = []
    self.games.each do |game|
      if game.home_team_id == team_id
        if game.outcome.include?('away') && game.outcome.include?('win')
          differences << game.away_goals - game.home_goals
        end
      elsif game.away_team_id == team_id
        if game.outcome.include?('home') && game.outcome.include?('win')
          differences << game.home_goals - game.away_goals
        end
      end
    end
    differences.max
  end

  def find_team_name(team_id)
    self.teams.find{|team| team.team_id == team_id}.team_name
  end

  def head_to_head(team_id)
    games_played_against = self.games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end

    opponent_games = games_played_against.group_by do |game|
      if game.away_team_id == team_id
        game.home_team_id
      else
        game.away_team_id
      end
    end

    opponent_games.transform_values! do |games|
      games_played = 0
      games_won = 0
      games.each do |game|
        games_played += 1
        if game.home_team_id == team_id
          games_won += 1 if game.outcome.include?('home') && game.outcome.include?('win')
        else
          games_won += 1 if game.outcome.include?('away') && game.outcome.include?('win')
        end
      end
      (games_won / games_played.to_f).round(2)
    end
    opponent_games.keys.each do |game_team_id|
      opponent_games[find_team_name(game_team_id)] = opponent_games[game_team_id]
      opponent_games.delete(game_team_id)
    end
    opponent_games
  end
end
