require 'pry'

module LeagueStats

  def count_of_teams
    count = self.game_teams.map do |team|
      team.team_id
    end
    count.uniq.length
  end

  def best_offense
    games_count = 0
    teams = self.game_teams.group_by do |game|
      game.team_id
    end

    ratios = teams.transform_values do |games|
      games_count = games.length
      goals = games.sum do |game|
        game.goals
      end
      (goals / games_count.to_f).round(2)
    end

    best_team_id = ratios.max_by{|team_id, goal_ratio| goal_ratio}.first
    self.teams.find{|team| team.team_id == best_team_id}.team_name
  end

  def worst_offense
    games_count = 0
    teams = self.game_teams.group_by do |game|
      game.team_id
    end

    ratios = teams.transform_values do |games|
      games_count = games.length
      goals = games.sum do |game|
        game.goals
      end
      (goals / games_count.to_f).round(2)
    end

    worst_team_id = ratios.min_by{|team_id, goal_ratio| goal_ratio}.first
    self.teams.find{|team| team.team_id == worst_team_id}.team_name
  end

  def ids_with_empty_arrays
    teams = {}
    self.games.each do |game|
      teams[game.home_team_id] = []
    end
    self.games.each do |game|
      teams[game.away_team_id] = []
    end
    teams
  end

  def goals_scored_against(teams)
    self.games.each do |game|
      teams.each do |team_id, goals|
        if team_id == game.home_team_id
          teams[team_id] << game.away_goals
        end
      end
      teams.each do |team_id, goals|
        if team_id == game.away_team_id
          teams[team_id] << game.home_goals
        end
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
    best_defense_id = teams.sort_by do |team_id, ratio|
      ratio
    end.first[0]
    self.teams.find{|team| team.team_id == best_defense_id}.team_name
  end

  # binding.pry
  def worst_defense
    teams = ids_with_empty_arrays
    teams = goals_scored_against(teams)
    teams.transform_values! do |goals|
      (goals.sum / goals.length.to_f).round(2)
    end
    worst_defense_id = teams.sort_by do |team_id, ratio|
      ratio
    end.last[0]
    self.teams.find{|team| team.team_id == worst_defense_id}.team_name
  end
end
