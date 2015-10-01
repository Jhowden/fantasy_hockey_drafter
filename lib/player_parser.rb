require "csv"

class PlayerParser
  attr_reader :path, :players

  def initialize( path )
    @path = path
    @players = {}
  end

  def parse()
    CSV.foreach( path, headers: true ) do |row|
      player_attribute_map = transformed_attributes row
      player = Player.new player_attribute_map
      players[player.player] = player
    end
  end

  private

  def transformed_attributes( data )
    rank         = data["Rank"].to_i
    player       = data["Player"]
    team         = data["Team"]
    position     = data["Position"]
    fhg_value    = data["FHG Value"].to_i
    games_played = data["Games Played"].to_i

    attributes_map = {
      rank: rank,
      player: player,
      team: team,
      position: position,
      fhg_value: fhg_value,
      games_played: games_played
    }
    
    merge_player_attributes( attributes_map, data )
  end

  def merge_player_attributes( attributes_map, data )
    if data["Position"] == "G"
      attributes_map.merge(
        sv_pct: data["SV%"].to_f,
        gaa: data["GAA"].to_f,
        wins: data["W"].to_i,
        shutouts: data["SO"].to_i
      )
    else
      attributes_map.merge(
        goals: data["G"].to_i,
        assists: data["A"].to_i,
        plus_minus: data["+/-"].to_i,
        sog: data["SOG"].to_i,
        gwg: data["GWG"].to_i,
        ppp: data["PPP"].to_i,
        shp: data["SHP"].to_i,
        hits: data["HITS"].to_i,
        fow: data["FOW"].to_i
      )
    end
  end
end