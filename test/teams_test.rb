require 'minitest/autorun'
require 'minitest/pride'
require './lib/teams'
require 'pry'
require './lib/stat_tracker'

class TeamsTest < Minitest::Test
  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/team_info_dummy.csv'
    game_teams_path = './data/game_teams_stats_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @teams = Teams.new(@stat_tracker.teams)
  end

  def test_teams_exist
    assert_instance_of Teams, @teams
  end

  def test_teams_methods_can_access_columns
    assert_equal ["23", "16", "14", "31"], @teams.franchise_id
    assert_equal "NJD", @teams.abbreviation.first
    assert_equal "/api/v1/teams/1", @teams.link.first
  end
end
