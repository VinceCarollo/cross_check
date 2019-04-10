require 'pry'

module TeamStats

  def team_info(team_id)
    info = {}
    self.teams.each do |team|
      if team.team_id == team_id
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
    team_id_array = self.game_teams.select{|game| game.team_id == team_id}
    games_by_season = team_id_array.group_by{|game| game.game_id[0..3]}

    best_game_id = games_by_season.transform_values do |games|
      games_played = 0
      games_won = 0
      games.each do |game|
        games_played += 1
        games_won += 1 if game.won == "TRUE"
      end
      (games_won / games_played.to_f)
    end

    best_season = best_game_id.max_by{|season, ratio| ratio}[0]
    self.games.find{|game| game.season[0..3].include?(best_season)}.season
  end

  def worst_season(team_id)
    games_played = self.game_teams.find_all{|game| game.team_id == team_id}
    games_by_season = games_played.group_by{|game| game.game_id[0..3]}

    games_by_season.transform_values! do |games|
      total_games = 0
      games_lost = 0
      games.each do |game|
        total_games += 1
        games_lost += 1 if game.won == "FALSE"
      end
      (games_lost / total_games.to_f)
    end

    worst_season = games_by_season.max_by{|season, ratio| ratio}.first
    self.games.find{|game| game.season[0..3] == worst_season}.season
  end

  def average_win_percentage(team_id)
    games_played = 0
    games_won = 0
    self.game_teams.each do |game|
      if game.team_id == team_id
        games_played += 1
        games_won += 1 if game.won == "TRUE"
      end
    end

    (games_won / games_played.to_f).round(2)
  end

  def most_goals_scored(team_id)
    game_array = self.game_teams.find_all do |game|
      game.team_id == team_id
    end
    game_array.max_by{|game| game.goals}.goals
  end

  def fewest_goals_scored(team_id)
    game_array = self.game_teams.find_all do |game|
      game.team_id == team_id
    end
    game_array.min_by{|game| game.goals}.goals
  end

  def favorite_opponent(team_id)
    games_played = self.games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end

    away_played = []
    home_played = []
    games_played.each do |game|
      away_played << game if game.home_team_id == team_id
      home_played << game if game.away_team_id == team_id
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
          games_won += 1 if game.outcome.include?("home")
        else
          games_won += 1 if game.outcome.include?("away")
        end
      end
      ratios[game_team_id] = games_won / games_played.to_f
    end
    fav_opponent = ratios.min_by{|game_team_id, ratio| ratio}[0]
    find_team_name(fav_opponent)
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

    teams_played_against = away_played_against.merge(home_played_against){|k, n, o| n + o}
    ratios = {}
    teams_played_against.each do |game_team_id, games|
      games_played = 0
      games_won = 0
      games.each do |game|
        games_played += 1
        if game.home_team_id == game_team_id
          games_won += 1 if game.outcome.include?("home")
        else
          games_won += 1 if game.outcome.include?("away")
        end
      end
      ratios[game_team_id] = games_won / games_played.to_f
    end
    rival_id = ratios.max_by{|game_team_id, ratio| ratio}[0]
    find_team_name(rival_id)
  end

  def biggest_team_blowout(team_id)
    differences = []
    self.games.each do |game|
      if game.home_team_id == team_id
        differences << game.home_goals - game.away_goals if game.outcome.include?('home')
      elsif game.away_team_id == team_id
        differences << game.away_goals - game.home_goals if game.outcome.include?('away')
      end
    end
    differences.max
  end

  def worst_loss(team_id)
    differences = []
    self.games.each do |game|
      if game.home_team_id == team_id
        differences << game.away_goals - game.home_goals if game.outcome.include?('away')
      elsif game.away_team_id == team_id
        differences << game.home_goals - game.away_goals
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
          games_won += 1 if game.outcome.include?('home')
        else
          games_won += 1 if game.outcome.include?('away')
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

  def seasonal_summary(team_id)
    total_games_played = self.games.find_all do |game|
      if game.away_team_id == team_id
        game.away_team_id
      elsif game.home_team_id == team_id
        game.home_team_id
      end
    end

    seasons_played = total_games_played.group_by{|game| game.season}
    seasons_played.transform_values! do |games|
      games.group_by do |game|
        game.type
      end
    end

    seasons_played.each do |season, grouped|
      if grouped.keys.length != 2
        seasons_played[season]['P'] = []
      end
    end

    seasons_played.values.each do |seasons|
      seasons.keys.each do |game_type|
        if game_type == 'P'
          seasons[:postseason] = seasons[game_type]
          seasons.delete(game_type)
        else
          seasons[:regular_season] = seasons[game_type]
          seasons.delete(game_type)
        end
      end
    end

    seasons_played.values.each do |games|
      games.transform_values! do |season|
        games_won = 0
        games_played = 0
        total_goals_scored = 0
        total_goals_against = 0
        season.each do |game|
          games_played += 1
          if game.home_team_id == team_id
            games_won += 1 if game.outcome.include?('home')
            total_goals_scored += game.home_goals
            total_goals_against += game.away_goals
          elsif game.away_team_id == team_id
            games_won += 1 if game.outcome.include?('away') 
            total_goals_scored += game.away_goals
            total_goals_against += game.home_goals
          end
        end
        {
          :win_percentage => (games_won / games_played.to_f).round(2),
          :total_goals_scored => total_goals_scored,
          :total_goals_against => total_goals_against,
          :average_goals_scored => (total_goals_scored / games_played.to_f).round(2),
          :average_goals_against => (total_goals_against / games_played.to_f).round(2)
        }
      end
    end

    seasons_played.each do |season, grouped|
      grouped.each do |type, stats|
        stats.each do |stat, value|
          seasons_played[season][type][stat] = 0 if value.to_f.nan?
        end
      end
    end
    seasons_played
  end
end
