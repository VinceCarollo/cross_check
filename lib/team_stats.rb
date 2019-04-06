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

    best_season = best_game_id.max_by do |season, ratio|
      ratio
    end[0]
    best_season

    final_return = self.games.find do |game|
      game.season[0..3].include?(best_season)
    end.season
    final_return
  end

end
