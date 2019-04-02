require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require 'pry'
require './lib/stat_tracker'

class GamesTest < Minitest::Test
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
    @games = Games.new(@stat_tracker.games)
  end

  def test_games_exisist
    assert_instance_of Games, @games
  end

  def test_methods_return_correct_columns
    assert_equal "P", @games.type.first
    assert_equal ["2", "2", "2"], @games.away_goals
    assert_equal "America/New_York", @games.venue_time_zone_id.first
  end
end
