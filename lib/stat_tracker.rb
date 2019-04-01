# Create a class method call from_csv
require 'csv'

class StatTracker

  def self.from_csv(locations)
    data = {
      games: [],
      teams: [],
      game_teams: []
    }
    locations.each do |name, path|
      CSV.read(path)
      if name == :games
        data[:games] << CSV.read(path)
      elsif name == :teams
        data[:teams] << CSV.read(path)
      elsif name == :game_team
        data[:game_team] << CSV.read(path)
      end
    end
    data
  end
end
