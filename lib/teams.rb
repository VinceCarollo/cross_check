class Teams
  attr_reader :team_id,
              :franchise_id,
              :short_name,
              :team_name,
              :abbreviation,
              :link

  def initialize(stats)
    @team_id       = stats[:team_id]
    @franchise_id  = stats[:franchiseid]
    @short_name    = stats[:shortname]
    @team_name     = stats[:teamname]
    @abbreviation  = stats[:abbreviation]
    @link          = stats[:link]
  end
end
