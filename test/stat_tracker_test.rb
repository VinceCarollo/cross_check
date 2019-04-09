require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require './lib/stat_tracker'
require './lib/stat_tracker_dummy_initiator'
require './lib/stat_tracker_initiator'



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

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("3")
  end

  def test_average_win_percentage
    assert_equal 0.5, @stat_tracker.average_win_percentage("26")
  end

  def test_most_goals_scored
    assert_equal 2, @stat_tracker.most_goals_scored("26")
  end

  def test_fewest_goals_scored
    assert_equal 1, @stat_tracker.fewest_goals_scored("26")
  end

  def test_favorite_opponent
    assert_equal 'Capitals', @stat_tracker.favorite_opponent("5")
  end

  def test_rival
    assert_equal 'Lightning', @stat_tracker.rival("5")
  end

  def test_biggest_team_blowout
    assert_equal 3, @stat_tracker.biggest_team_blowout("5")
  end

  def test_worst_loss
    stat_tracker = StatTrackerInitiator.create

    assert_equal 9, stat_tracker.worst_loss("5")
  end

  def test_find_team_name
    assert_equal 'Penguins', @stat_tracker.find_team_name("5")
  end

  def test_head_to_head
    expected = {
              "Lightning"=>0.67,
              "Capitals"=>1.0
              }
    assert_equal expected, @stat_tracker.head_to_head("5")
  end

  def test_seasonal_summary
    expected = {
      "20122013"=>
      {:regular_season=>
        {:win_percentage=>1.0,
         :total_goals_scored=>2,
         :total_goals_against=>1,
         :average_goals_scored=>2.0,
         :average_goals_against=>1.0},
       :postseason=>
        {:win_percentage=>0,
         :total_goals_scored=>0,
         :total_goals_against=>0,
         :average_goals_scored=>0,
         :average_goals_against=>0}},
      "20152016"=>
      {:regular_season=>
          {:win_percentage=>1.0,
           :total_goals_scored=>5,
           :total_goals_against=>3,
           :average_goals_scored=>5.0,
           :average_goals_against=>3.0},
       :postseason=>
          {:win_percentage=>0,
           :total_goals_scored=>0,
           :total_goals_against=>0,
           :average_goals_scored=>0,
           :average_goals_against=>0}},
        "20172018"=>
        {:regular_season=>
          {:win_percentage=>1.0,
           :total_goals_scored=>3,
           :total_goals_against=>0,
           :average_goals_scored=>3.0,
           :average_goals_against=>0.0},
         :postseason=>
          {:win_percentage=>0,
           :total_goals_scored=>0,
           :total_goals_against=>0,
           :average_goals_scored=>0,
           :average_goals_against=>0
          }
        }
      }


    assert_equal expected, @stat_tracker.seasonal_summary("18")
  end

  def test_best_defense
    assert_equal "Predators", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Sharks", @stat_tracker.worst_defense
  end

  def test_winningest_team
    assert_equal 'Bruins', @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal 'Bruins', @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Blackhawks", "Sharks", "Kings", "Wild"], @stat_tracker.worst_fans
  end

  def test_best_offense
    assert_equal 'Lightning', @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal 'Sabres', @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    stat_tracker = StatTrackerInitiator.create

    assert_equal 'Capitals', stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    stat_tracker = StatTrackerInitiator.create

    assert_equal 'Golden Knights', stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    stat_tracker = StatTrackerInitiator.create

    assert_equal 'Sabres', stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    stat_tracker = StatTrackerInitiator.create

    assert_equal 'Sabres', stat_tracker.lowest_scoring_home_team
  end

  def test_biggest_bust
    stat_tracker = StatTrackerInitiator.create

    assert_equal 'Canucks', stat_tracker.biggest_bust("20122013")
  end

  def test_biggest_surprise
    stat_tracker = StatTrackerInitiator.create

    assert_equal 'Sharks' , stat_tracker.biggest_surprise("20122013")
  end

  def test_ids_with_game_arrays_by_season
    assert_equal 20, @stat_tracker.ids_with_game_arrays_by_season("20122013").length
  end

  def test_winningest_coach
    stat_tracker = StatTrackerInitiator.create

    assert_equal "Dan Lacroix", stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    stat_tracker = StatTrackerInitiator.create

    assert_equal "Martin Raymond", stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team
    stat_tracker = StatTrackerInitiator.create

    assert_equal "Lightning", stat_tracker.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    stat_tracker = StatTrackerInitiator.create

    assert_equal "Senators", stat_tracker.least_accurate_team("20122013")
  end

  def test_most_hits
    stat_tracker = StatTrackerInitiator.create

    assert_equal "Islanders", stat_tracker.most_hits("20142015")
  end

  def test_fewest_hits
    stat_tracker = StatTrackerInitiator.create

    assert_equal "Wild", stat_tracker.fewest_hits("20142015")
  end
end
