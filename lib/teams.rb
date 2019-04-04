class Teams
  attr_reader :team_id,
              :franchise_id,
              :short_name,
              :team_name,
              :abbreviation,
              :link

  def initialize(row)
    @team_id       = row[0]
    @franchise_id  = row[1]
    @short_name    = row[2]
    @team_name     = row[3]
    @abbreviation  = row[4]
    @link          = row[5]
  end
end
