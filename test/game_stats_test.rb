require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_stats'
require './lib/stat_tracker'
require './lib/games'
require './lib/stat_tracker_dummy_initiator'
require 'pry'


class GameStatsTest < Minitest::Test

  def setup
    @stat_tracker = StatTrackerDummyInitiator.create
    @games = Games.new(@stat_tracker.games)
    @game_stats = GameStats.new(@games)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  # def test_highest_total_score
  #   assert_equal 12, @game_stats.highest_total_score
  # end

end
