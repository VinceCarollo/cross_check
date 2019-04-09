require 'pry'
module SeasonStats

  def ids_with_game_arrays_by_season(season_id)
    teams = ids_with_empty_arrays
    self.games.each do |game|
      teams.each do |team_id, values|
        if team_id == game.home_team_id || team_id == game.away_team_id
          teams[team_id] << game if game.season == season_id
        end
      end
    end
    teams
  end

  def biggest_bust(season_id)
  teams = ids_with_game_arrays_by_season(season_id)

    teams.transform_values! do |games|
      games.group_by do |game|
        game.type
      end
    end

    teams.each do |team_id, games_by_type|
      games_by_type.transform_values! do |games|
        games_played = 0
        games_won = 0
        games.each do |game|
            games_played += 1
          if team_id == game.away_team_id && game.outcome.include?("away")
            games_won += 1
          elsif team_id == game.home_team_id && game.outcome.include?("home")
            games_won += 1
          end
        end
       (games_won / games_played.to_f)
      end
    end
    teams.each do |team_id, ratio_types|
      if ratio_types.empty?
        teams.delete(team_id)
      end
    end
    teams.transform_values! do |ratio_types|
      if ratio_types.keys.length == 2
        ratio_types["P"] - ratio_types["R"]
      elsif ratio_types.keys.length == 1
        0
      end
    end
    duh_sabres = teams.min_by do |team_id, ratio|
      ratio
    end
    find_team_name(duh_sabres[0])
  end

  def biggest_surprise(season_id)
    teams = ids_with_game_arrays_by_season(season_id)
    teams.transform_values! do |games|
      games.group_by do |game|
        game.type
      end
    end

    teams.each do |team_id, games_by_type|
      games_by_type.transform_values! do |games|
        games_played = 0
        games_won = 0
        games.each do |game|
            games_played += 1
          if team_id == game.away_team_id && game.outcome.include?("away")
            games_won += 1
          elsif team_id == game.home_team_id && game.outcome.include?("home")
            games_won += 1
          end
        end
       (games_won / games_played.to_f)
      end
    end
    teams.each do |team_id, ratio_types|
      if ratio_types.empty?
        teams.delete(team_id)
      end
    end
    teams.transform_values! do |ratio_types|
      if ratio_types.keys.length == 2
        ratio_types["P"] - ratio_types["R"]
      elsif ratio_types.keys.length == 1
        0
      end
    end
    duh_sabres = teams.max_by do |team_id, ratio|
      ratio
    end

    find_team_name(duh_sabres[0])
  end

  def winningest_coach(season_id)
    teams = ids_with_game_arrays_by_season(season_id)
    teams.each do |team_id, games|
      if games.length == 0
        teams.delete(team_id)
      end
    end

    #Game CSV has season, team ids (split home/away), game_id
    #Game Team CSV has team_id and head coach names

    teams.each do |team_id, games|
      season_games = 0
      season_wins = 0
      games.each do |game|
        season_games += 1
        if game.home_team_id == team_id && game.outcome.include?("home")
          season_wins += 1
        elsif game.away_team_id == team_id && game.outcome.include?("away")
          season_wins += 1
        end
      end
      teams[team_id] = (season_wins/season_games.to_f)
    end

    best_team = teams.max_by do |team_id, ratio|
      ratio
    end.first

    self.game_teams.find do |game|
      game.game_id[0..3] == season_id[0..3] && game.team_id == best_team
    end.head_coach

  end
end
