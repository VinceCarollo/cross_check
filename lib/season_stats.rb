require 'pry'
module SeasonStats

  def biggest_bust(season_id)
    teams = ids_with_empty_arrays
    self.games.each do |game|
        teams.each do |team_id, values|
          if team_id == game.home_team_id || team_id == game.away_team_id
            teams[team_id] << game if game.season == season_id
          end
        end
    end
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
    teams = ids_with_empty_arrays
    self.games.each do |game|
        teams.each do |team_id, values|
          if team_id == game.home_team_id || team_id == game.away_team_id
            teams[team_id] << game if game.season == season_id
          end
        end
    end
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
end
