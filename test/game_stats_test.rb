require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_stats'
require './lib/stat_tracker'
require './lib/games'
require 'pry'


class GameStatsTest < Minitest::Test

  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @games = Games.new(@stat_tracker.games)
    @game_stats = GameStats.new(@games)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

end
