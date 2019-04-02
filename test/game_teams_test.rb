require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require 'pry'
require './lib/stat_tracker'

class GameTeamsTest < Minitest::Test

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
   @game_teams = GameTeams.new(@stat_tracker.game_teams)
 end

 def test_game_teams_exists
   @game_teams = GameTeams.new(@stat_tracker.game_teams)
 end

 def test_methods_return_correct_columns
   assert_equal "2012030221", @game_teams.game_id.first
   assert_equal "John Tortorella", @game_teams.head_coach.first
   assert_equal ["3", "4", "5"], @game_teams.power_play_opportunities
 end
end
