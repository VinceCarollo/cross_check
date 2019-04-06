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
    assert_equal 0.53, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.47, @stat_tracker.percentage_visitor_wins
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>6,
                "20132014"=>1,
                "20162017"=>4,
                "20172018"=>3,
                "20152016"=>5}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 5.37, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
                "20122013"=>4.67,
                "20132014"=>6.0,
                "20162017"=>5.75,
                "20172018"=>4.67,
                "20152016"=>6.2
              }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 11, @stat_tracker.count_of_teams
  end

  # def test_best_offense
  #   assert_equal "Lightning", @stat_tracker.best_offense
  # end

  # def test_worst_offense
  #   assert_equal "Sabres", @stat_tracker.worst_offense
  # end

  def test_team_info
    expected = {
              "abbreviation"=>"LAK",
              "franchise_id"=>"14",
              "link"=>"/api/v1/teams/26",
              "short_name"=>"Los Angeles",
              "team_id"=>"26",
              "team_name"=>"Kings"
            }
    assert_equal expected, @stat_tracker.team_info("26")
  end

  def test_best_season
    assert_equal "20152016", @stat_tracker.best_season("26")
  end


end
