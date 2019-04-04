require 'pry'

module LeagueStats

  def count_of_teams
    count = self.game_teams.map do |team|
      team.team_id
    end
    count.uniq.length
  end

  def best_offense
    #highest average number of goals scored per game across all seasons
    #what is the team id for that team??

    self.teams do |team|
      team
    end

    maybe = lowest_total_score
    binding.pry
    return maybe
    #returning team_name
  end

end
