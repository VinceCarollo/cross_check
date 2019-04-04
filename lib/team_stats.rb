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

end
