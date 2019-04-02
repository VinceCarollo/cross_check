
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

 def initialize(stats)
   @game_id                  = stats[:game_id]
   @team_id                  = stats[:team_id]
   @hoa                      = stats[:hoa]
   @won                      = stats[:won]
   @settled_in               = stats[:settled_in]
   @head_coach               = stats[:head_coach]
   @goals                    = stats[:goals]
   @shots                    = stats[:shots]
   @hits                     = stats[:hits]
   @pim                      = stats[:pim]
   @power_play_opportunities = stats[:powerplayopportunities]
   @power_play_goals         = stats[:powerplaygoals]
   @face_off_win_percentage  = stats[:faceoffwinpercentage]
   @giveaways                = stats[:giveaways]
   @takeaways                = stats[:takeaways]
 end
end
