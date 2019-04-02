require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }


    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_stat_tracker_exists
    assert StatTracker, @stat_tracker
  end

  def test_stat_tracker_games_method_has_attributes
    assert @stat_tracker.games.include?("game_id")
  end
end
