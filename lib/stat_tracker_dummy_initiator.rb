require_relative './stat_tracker'

class StatTrackerDummyInitiator
  def self.create
    game_path = './data/game_dummy.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    StatTracker.from_csv(locations)
  end
end
