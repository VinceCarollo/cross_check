class Games
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :outcome,
              :home_rink_side_start,
              :venue,
              :venue_link,
              :venue_time_zone_id,
              :venue_time_zone_offset,
              :venue_time_zone_tz

  def initialize(stats)
    @game_id                = stats[:game_id]
    @season                 = stats[:season]
    @type                   = stats[:type]
    @date_time              = stats[:date_time]
    @away_team_id           = stats[:away_team_id]
    @home_team_id           = stats[:home_team_id]
    @away_goals             = stats[:away_goals]
    @home_goals             = stats[:home_goals]
    @outcome                = stats[:outcome]
    @home_rink_side_start   = stats[:home_rink_side_start]
    @venue                  = stats[:venue]
    @venue_link             = stats[:venue_link]
    @venue_time_zone_id     = stats[:venue_time_zone_id]
    @venue_time_zone_offset = stats[:venue_time_zone_offset]
    @venue_time_zone_tz     = stats[:venue_time_zone_tz]
  end
end
