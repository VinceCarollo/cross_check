require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/teams'
require 'pry'
require './lib/stat_tracker'
require './lib/stat_tracker_dummy_initiator'

class TeamsTest < Minitest::Test
  def setup
    @stat_tracker = StatTrackerDummyInitiator.create
    @teams = Teams.new(@stat_tracker.teams)
  end

  def test_teams_exist
    assert_instance_of Teams, @teams
  end

  def test_teams_methods_can_access_columns
    assert_equal 33, @stat_tracker.teams.length
    assert_equal "/api/v1/teams/14", @stat_tracker.teams[3].link
    assert_equal "Oilers", @stat_tracker.teams[30].team_name
    assert_equal "Phoenix", @stat_tracker.teams[18].short_name
    assert_equal "36", @stat_tracker.teams[25].franchise_id
    assert_equal "17", @stat_tracker.teams[7].team_id
    assert_equal "Coyotes", @stat_tracker.teams[18].team_name
  end
end
