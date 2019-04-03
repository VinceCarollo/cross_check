require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/stat_tracker'
require './lib/stat_tracker_dummy_initiator'


class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTrackerDummyInitiator.create
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_highest_total_score
    assert_equal 9, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 33.33, @stat_tracker.percentage_home_wins("26")
  end

  def test_percentage_visitor_wins
    assert_equal 50.0, @stat_tracker.percentage_visitor_wins("14")
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 6
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season("20122013")
  end

  def test_average_goals_per_game
    assert_equal 5.37, @stat_tracker.average_goals_per_game
  end
end
