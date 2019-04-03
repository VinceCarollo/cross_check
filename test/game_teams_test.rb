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
   assert_instance_of GameTeams, @game_teams
 end

 def test_methods_return_correct_columns
   assert_equal "2012030221" , @stat_tracker.game_teams[0].game_id
   assert_equal "51.7", @stat_tracker.game_teams[2].face_off_win_percentage
   assert_equal "Darryl Sutter", @stat_tracker.game_teams[6].head_coach
   assert_equal "0", @stat_tracker.game_teams[10].power_play_goals
   assert_equal "4", @stat_tracker.game_teams[11].pim
   assert_equal "10", @stat_tracker.game_teams[13].giveaways
   assert_equal 14, @stat_tracker.game_teams.length
 end
end
