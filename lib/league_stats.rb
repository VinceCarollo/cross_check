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

end
