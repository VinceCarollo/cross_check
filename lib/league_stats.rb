require 'pry'

module LeagueStats

  def count_of_teams
    count = self.game_teams.map{|team| team.team_id}
    count.uniq.length
  end

  def best_offense
    games_count = 0
    teams = self.game_teams.group_by{|game| game.team_id}

    ratios = teams.transform_values do |games|
      games_count = games.length
      goals = games.sum{|game| game.goals}
      (goals / games_count.to_f).round(2)
    end

    best_team_id = ratios.max_by{|team_id, goal_ratio| goal_ratio}.first
    find_team_name(best_team_id)
  end

  def worst_offense
    games_count = 0
    teams = self.game_teams.group_by{|game| game.team_id}

    ratios = teams.transform_values do |games|
      games_count = games.length
      goals = games.sum{|game| game.goals}
      (goals / games_count.to_f).round(2)
    end

    worst_team_id = ratios.min_by{|team_id, goal_ratio| goal_ratio}.first
    find_team_name(worst_team_id)
  end

  def ids_with_empty_arrays
    teams = {}
    self.games.each{|game| teams[game.home_team_id] = []}
    self.games.each{|game| teams[game.away_team_id] = []}
    teams
  end

  def goals_scored_against(teams)
    self.games.each do |game|
      teams.each do |team_id, goals|
        teams[team_id] << game.away_goals if team_id == game.home_team_id
      end

      teams.each do |team_id, goals|
        teams[team_id] << game.home_goals if team_id == game.away_team_id
      end
    end
    teams
  end

  def best_defense
    teams = ids_with_empty_arrays
    teams = goals_scored_against(teams)
    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end

    best_defense_id = teams.sort_by{|team_id, ratio| ratio}.first[0]
    find_team_name(best_defense_id)
  end

  def worst_defense
    teams = ids_with_empty_arrays
    teams = goals_scored_against(teams)
    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end

    worst_defense_id = teams.sort_by{|team_id, ratio| ratio}.last[0]
    find_team_name(worst_defense_id)
  end

  def highest_scoring_visitor
    teams = ids_with_empty_arrays
    self.games.each do |game|
      teams.each do |team_id, goals|
        teams[team_id] << game.away_goals if team_id == game.away_team_id
      end
    end

    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end

    highest_id = teams.max_by{|team_id, ratio|ratio}[0]
    find_team_name(highest_id)
  end

  def highest_scoring_home_team
    teams = ids_with_empty_arrays
    self.games.each do |game|
      teams.each do |team_id, goals|
        teams[team_id] << game.home_goals if team_id == game.home_team_id
      end
    end

    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end

    highest_id = teams.max_by{|team_id, ratio|ratio}[0]
    find_team_name(highest_id)
  end

  def lowest_scoring_visitor
    teams = ids_with_empty_arrays
    self.games.each do |game|
      teams.each do |team_id, goals|
        teams[team_id] << game.away_goals if team_id == game.away_team_id
      end
    end

    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end

    highest_id = teams.min_by{|team_id, ratio|ratio}[0]
    find_team_name(highest_id)
  end

  def lowest_scoring_home_team
    teams = ids_with_empty_arrays
    self.games.each do |game|
      teams.each do |team_id, goals|
        teams[team_id] << game.home_goals if team_id == game.home_team_id
      end
    end

    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end

    highest_id = teams.min_by{|team_id, ratio|ratio}[0]
    find_team_name(highest_id)
  end

  def winningest_team
    teams = self.game_teams.group_by{|game| game.team_id}

    teams.transform_values! do |games|
      wins = 0
      games_played = 0
      games.each do |game|
        games_played += 1
        wins += 1 if game.won == "TRUE"
      end
      (wins.to_f / games_played).round(2)
    end

    winningest_team_id = teams.max_by{|team_id, win_ratio| win_ratio}[0]
    find_team_name(winningest_team_id)
  end

  def best_fans
    teams = self.game_teams.group_by{|game| game.team_id}

    teams.transform_values! do |games|
      home_wins = 0
      away_wins = 0
      games_played = 0
      games.each do |game|
        games_played += 1
        home_wins += 1 if game.won == "TRUE" && game.hoa == "home"
        away_wins += 1 if game.won == "TRUE" && game.hoa == "away"
      end
      (home_wins.to_f / games_played) - (away_wins.to_f / games_played)
    end
    best_fans_id = teams.max_by{|team_id, difference| difference}[0]
    find_team_name(best_fans_id)
  end

  def worst_fans
    teams = self.game_teams.group_by{|game| game.team_id}

    teams.transform_values! do |games|
      home_wins = 0
      away_wins = 0
      games_played = 0
      games.each do |game|
        games_played += 1
        home_wins += 1 if game.won == "TRUE" && game.hoa == "home"
        away_wins += 1 if game.won == "TRUE" && game.hoa == "away"
      end
      home_wins < away_wins
    end
    teams.delete_if{|team_id, more_away_wins| !more_away_wins}
    teams.keys.map{|team_id| find_team_name(team_id)}
  end
end
