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
  #Season with the highest win percentage for a team.
  #expecting an integer of the season

  #game_teams has access to team ID and Wins. Game ID has first 4 numbers of season


  #start with the team, group by game_id's
    game_id_hash = self.game_teams.group_by do |game|
      game.game_id
    end


  #find the game_ID with the most "WINS"
    most_wins = game_id_hash.transform_values do |value|
      value.map do |v|
        v.won
      end
    end

     most_wins #hash of game_id's with won outcome
     best_game_id = most_wins.max_by do |key, value|
       if value == "TRUE"
         key
       end
     end

     binding.pry
     converted = best_game_id[0].delete[-6..-1]
#games has access to Season, and away or home id's
     self.games.find do |game|
       if game.season.include?(converted)
       end
     end

  #return the game_id and save into instance variable
  #match the first four charaters of season with instance variable, return that season

  end

end
