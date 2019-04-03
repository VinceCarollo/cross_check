
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
   @goals                    = row[6]
   @shots                    = row[7]
   @hits                     = row[8]
   @pim                      = row[9]
   @power_play_opportunities = row[10]
   @power_play_goals         = row[11]
   @face_off_win_percentage  = row[12]
   @giveaways                = row[13]
   @takeaways                = row[14]
 end
end
