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
    @game_stats = GameStats.new(@stat_tracker.games)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_highest_total_score
    assert_equal 9, @game_stats.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @game_stats.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 5, @game_stats.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 33.33, @game_stats.percentage_home_wins("26")
  end

  def test_percentage_visitor_wins
    assert_equal 50.0, @game_stats.percentage_visitor_wins("14")
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 6
    }
    assert_equal expected, @game_stats.count_of_games_by_season("20122013")
  end

  def test_average_goals_per_game
    assert_equal 5.37, @game_stats.average_goals_per_game
  end
end
