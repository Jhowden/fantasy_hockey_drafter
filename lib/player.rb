class Player
    attr_reader :rank, :player, :team, :position, :fhg_value, :games_played,
      :sv_pct, :gaa, :wins, :shutouts, :goals, :assists, :plus_minus,
      :sog, :gwg, :ppp, :shp, :hits, :fow, :taken

  def initialize( attributes )
    @rank         = attributes[:rank]
    @player       = attributes[:player]
    @team         = attributes[:team]
    @position     = attributes[:position]
    @fhg_value    = attributes[:fhg_value]
    @games_played = attributes[:games_played]
    @sv_pct       = attributes[:sv_pct]
    @gaa          = attributes[:gaa]
    @wins         = attributes[:wins]
    @shutouts     = attributes[:shutouts]
    @goals        = attributes[:goals]
    @assists      = attributes[:assists]
    @plus_minus   = attributes[:plus_minus]
    @sog          = attributes[:sog]
    @gwg          = attributes[:gwg]
    @ppp          = attributes[:ppp]
    @shp          = attributes[:shp]
    @hits         = attributes[:hits]
    @fow          = attributes[:fow]
    @taken        = false
  end

  def drafted!()
    @taken = true
  end

  def update_ranking( other_rank )
    @rank = ( rank.to_f + other_rank ) / 2
  end
end