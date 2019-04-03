require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require 'pry'
require './lib/stat_tracker'
require './lib/stat_tracker_dummy_initiator'

class GamesTest < Minitest::Test
  def setup
    @stat_tracker = StatTrackerDummyInitiator.create
    @games = Games.new(@stat_tracker.games)
  end

  def test_games_exisist
    assert_instance_of Games, @games
  end

  def test_methods_return_correct_columns
    assert_equal "P", @games.type.first
    expected = ["2", "2", "2", "3", "2", "1", "1", "4", "2", "3", "3", "0", "2", "3", "7", "4", "5", "1", "3"]
    assert_equal expected, @games.away_goals
    assert_equal "America/New_York", @games.venue_time_zone_id.first
  end
end
