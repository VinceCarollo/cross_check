require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require 'pry'
require './lib/stat_tracker'
require './lib/stat_tracker_dummy_initiator'

class GameTeamsTest < Minitest::Test

 def setup
   @stat_tracker = StatTrackerDummyInitiator.create
   @game_teams = GameTeams.new(@stat_tracker.game_teams)
 end

 def test_game_teams_exists
   @game_teams = GameTeams.new(@stat_tracker.game_teams)
 end

 def test_methods_return_correct_columns
   assert_equal "2012030221", @game_teams.game_id.first
   assert_equal "John Tortorella", @game_teams.head_coach.first

   expected = ["3", "4", "5", "3", "3", "5", "5", "3", "2", "2", "2", "2", "3", "3"]
   assert_equal expected, @game_teams.power_play_opportunities
 end
end
