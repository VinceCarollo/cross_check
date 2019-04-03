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

  def test_it_can_get_correct_info_from_all_different_sources

    actual = @stat_tracker.game_teams[:hoa][0]

    assert_equal "away", actual



  end
end
