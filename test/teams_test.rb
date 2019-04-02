require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/teams'
require 'pry'
require './lib/stat_tracker'

class TeamsTest < Minitest::Test
  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/team_info.csv'
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
    expected = ["23", "16", "14", "31", "6", "10", "17", "12", "29", "34", "20", "11", "30", "1", "37", "24", "18", "32", "28", "22", "21", "27", "15", "33", "5", "36", "35", "38", "26", "19", "25", "28", "35"]
    assert_equal expected, @teams.franchise_id
    assert_equal "NJD", @teams.abbreviation.first
    assert_equal "/api/v1/teams/1", @teams.link.first
  end
end
