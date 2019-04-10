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
      games.group_by{|game| game.type}
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

    biggest_bust_id = teams.min_by{|team_id, ratio| ratio}[0]
    find_team_name(biggest_bust_id)
  end

  def biggest_surprise(season_id)
    teams = ids_with_game_arrays_by_season(season_id)
    teams.transform_values!{|games| games.group_by{|game| game.type}}

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

    biggest_surprise_id = teams.max_by{|team_id, ratio| ratio}[0]
    find_team_name(biggest_surprise_id)
  end

  def winningest_coach(season_id)
    season_game = self.game_teams.find_all do |game|
      game.game_id[0..3].include?(season_id[0..3])
    end

    head_coaches = season_game.group_by{|game| game.head_coach}
    head_coaches.transform_values! do |games|
      total_games = 0
      coach_wins = games.count do |game|
        total_games += 1
        game.won == "TRUE"
      end
      coach_wins / total_games.to_f
    end

    head_coaches.max_by{|coach, ratio| ratio}.first
  end

  def worst_coach(season_id)
    season_game = self.game_teams.find_all do |game|
      game.game_id[0..3].include?(season_id[0..3])
    end

    head_coaches = season_game.group_by{|game| game.head_coach}
    head_coaches.transform_values! do |games|
      total_games = 0
      coach_losses = games.count do |game|
        total_games += 1
        game.won == "FALSE"
      end
      coach_losses / total_games.to_f
    end

    head_coaches.max_by{|coach, ratio| ratio}.first
  end

  def most_accurate_team(season_id)
    games_by_season = self.game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end

    games_by_team_id = games_by_season.group_by{|game| game.team_id}

    games_by_team_id.transform_values! do |games|
      total_goals = 0
      total_shots = 0
      games.each do |game|
        total_goals += game.goals
        total_shots += game.shots
      end
      total_goals / total_shots.to_f
    end

    most_accurate = games_by_team_id.max_by{|team_id, ratio| ratio}.first
    find_team_name(most_accurate)
  end

  def least_accurate_team(season_id)
    games_by_season = self.game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end

    games_by_team_id = games_by_season.group_by{|game| game.team_id}

    games_by_team_id.transform_values! do |games|
      total_goals = 0
      total_shots = 0
      games.each do |game|
        total_goals += game.goals
        total_shots += game.shots
      end
      total_goals / total_shots.to_f
    end

    most_accurate = games_by_team_id.min_by{|team_id, ratio| ratio}.first
    find_team_name(most_accurate)
  end

  def most_hits(season_id)
    games_by_season = self.game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end

    games_by_team_id = games_by_season.group_by{|game| game.team_id}

    games_by_team_id.transform_values!.each do |games_array|
      game_hits_total = 0
      games_array.each do |game|
        game_hits_total += game.hits
      end
      game_hits_total
    end

    highest_hitting_team_id = games_by_team_id.max_by do |team_id, total_hits|
      total_hits
    end.first

    find_team_name(highest_hitting_team_id)
  end

  def fewest_hits(season_id)
    games_by_season = self.game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end

    games_by_team_id = games_by_season.group_by{|game| game.team_id}

    games_by_team_id.transform_values!.each do |games_array|
      game_hits_total = 0
      games_array.each do |game|
        game_hits_total += game.hits
      end
      game_hits_total
    end

    highest_hitting_team_id = games_by_team_id.min_by do |team_id, total_hits|
      total_hits
    end.first

    find_team_name(highest_hitting_team_id)
  end

  def power_play_goal_percentage(season_id)
    season_games = self.game_teams.find_all do |game|
      game.game_id[0..3].include?(season_id[0..3])
    end

    total_goals = 0
    power_play_goals = 0
    season_games.each do |games|
      power_play_goals += games.power_play_goals
      total_goals += games.goals
    end

    (power_play_goals/total_goals.to_f).round(2)
  end

end
