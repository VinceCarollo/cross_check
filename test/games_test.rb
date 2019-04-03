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

  end

  def test_games_exisist
    @stat_tracker.game_teams.each do |game|
      assert_instance_of Games, game
    end
  end

  def test_games_has_attributes
    assert_equal "2012030221" , @stat_tracker.game_teams[0].game_id
    assert_equal "3", @stat_tracker.game_teams[0].season
    assert_equal "away", @stat_tracker.game_teams[0].type
    assert_equal "FALSE", @stat_tracker.game_teams[0].date_time
  end


end
