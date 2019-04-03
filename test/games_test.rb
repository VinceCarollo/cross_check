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

  def test_game_teams_exist
    assert_instance_of Games, @games
  end

  def test_games_has_attributes
    assert_equal "2012030221" , @stat_tracker.games[0].game_id
    assert_equal "2013-05-21", @stat_tracker.games[2].date_time
    assert_equal "R", @stat_tracker.games[6].type
    assert_equal "left", @stat_tracker.games[9].home_rink_side_start
    assert_equal "CONSOL Energy Center", @stat_tracker.games[17].venue
    assert_equal "away win REG", @stat_tracker.games[13].outcome
    assert_equal "20162017", @stat_tracker.games[18].season
  end


end
