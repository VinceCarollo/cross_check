
class GameTeams
 attr_reader :game_id,
             :team_id,
             :hoa,
             :won,
             :settled_in,
             :head_coach,
             :goals,
             :shots,
             :hits,
             :pim,
             :power_play_opportunities,
             :power_play_goals,
             :face_off_win_percentage,
             :giveaways,
             :takeaways

 def initialize(row)
   @game_id                  = row[0]
   @team_id                  = row[1]
   @hoa                      = row[2]
   @won                      = row[3]
   @settled_in               = row[4]
   @head_coach               = row[5]
   @goals                    = row[6].to_i
   @shots                    = row[7].to_i
   @hits                     = row[8].to_i
   @pim                      = row[9].to_i
   @power_play_opportunities = row[10].to_i
   @power_play_goals         = row[11].to_i
   @face_off_win_percentage  = row[12].to_f
   @giveaways                = row[13].to_i
   @takeaways                = row[14].to_i
 end
end
