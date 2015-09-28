require_relative "player"

DISPLAY = <<-STRING
+----------------------------------------+-----+-----+-------------------------------------------------------------------------------------------------------------------+
|        TAKEN PLAYERS     |             |  |  |                                  NOTABLE_PLAYERS                                                                        |
+--------------------------+-------------+--+--+----------------------------+----------+------+---+---+-----+-----+-----+-----+-----+------+-----+---+----+-----+--------+
|    NAME                  |  POSITION   |  |  |  NAME                      | POSTIION | FHGV | G | A | SOG | PPP | SHP | +/- | GWG | HITS | FOW | W | SO | GAA | SV_PCT |
+--------------------------+-------------+--+--+----------------------------+----------+------+---+---+-----+-----+-----+-----+-----+------+-----+---+----+-----+--------+
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
|     *                    |      *      |  |  |    %                       |    %     |  %   | % | % |  %  |  %  |  %  |  %  |  %  |  %   |  %  | ^ | ^  |  ^  |   ^    |
+--------------------------+------------------------------------------------+----------+------+---+---+-----+-----+-----+-----+-----+------+-----+---+----+-----+--------+
|                                                       STATISTICS                                                                                                       |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|              GOALS: $  /233            ASSISTS: $  /427                 PPP: $  /215           SHP: $ /13        PLUS/MINUS: $ /72                                     |
|  SOG: $   /2267              GWG: $ /41                  HITS: $  /969              FOW: $   /2382                                                                     |
|                                                                                                                                                                        |
|               WINS: @ /75                GAA: @   /2.36             SV_PCT: @   /0.92          SHUTOUTS: @ /11                                                         |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
STRING

class PrintFormatter
  attr_reader :notable_players

  def initialize()
    @notable_players = [
      Player.new( {rank: 1, player: "The second player", fhg_value: 100, goals: 35, assists: 15, plus_minus: -15,
        sog: 298, ppp: 15, shp: 10, hits: 60, gwg: 2, fow: 690, w: " ", shutouts: " ", gaa: " ", sv_pct: " ", position: "C"} ), 
      Player.new( {rank: 65, player: "The third player", fhg_value: 370, goals: 45, assists: 40, plus_minus: 25,
        sog: 400, ppp: 26, shp: 2, hits: 19, gwg: 8, fow: 6, w: " ", shutouts: " ", gaa: " ", sv_pct: " ", position: "RW"} ),
      Player.new( {rank: 3, player: "The fifth player", fhg_value: 20, goals: " ", assists: " ",
      sog: " ", ppp: " ",  shp: " ", w: 20, shutouts: 3, gaa: 2.43, sv_pct: 0.918, fow: " ",  position: "G"} )]
  end

  def print( taken_players )
    display = DISPLAY.dup
    taken_players.each do |pname, p|
      display.sub!( "     *                    ", add_additional_spaces( pname, "     *                    " ) )
      display.sub!( "      *      ", add_additional_spaces( p.position, "      *      " ) )
    end

    notable_players.each do |p|
      display.sub!( "    %                     ", add_additional_spaces( p.player,  "    %                     " ) )
      display.sub!( "    %     ", add_additional_spaces( p.position,  "    %     " ) )
      display.sub!( "  %   ", add_additional_spaces( p.fhg_value.to_s,  "  %   " ) )
      display.sub!( " % ", add_additional_spaces( p.goals.to_s,  " % " ) )
      display.sub!( " % ", add_additional_spaces( p.assists.to_s,  " % " ) )
      display.sub!( "  %  ", add_additional_spaces( p.sog.to_s,  "  %  " ) )
      display.sub!( "  %  ", add_additional_spaces( p.ppp.to_s,  "  %  " ) )
      display.sub!( "  %  ", add_additional_spaces( p.shp.to_s,  "  %  " ) )
      display.sub!( "  %  ", add_additional_spaces( p.plus_minus.to_s,  "  %  " ) )
      display.sub!( "  %  ", add_additional_spaces( p.gwg.to_s,  "  %  " ) )
      display.sub!( "  %   ", add_additional_spaces( p.hits.to_s,  "  %   " ) )
      display.sub!( "  %  ", add_additional_spaces( p.fow.to_s,  "  %  " ) ) 
      display.sub!( " ^ ", add_additional_spaces( p.wins.to_s,  " ^ " ) )
      display.sub!( " ^  ", add_additional_spaces( p.shutouts.to_s,  " ^  " ) )
      display.sub!( "  ^  ", add_additional_spaces( p.gaa.to_s,  "  ^  " ) )
      display.sub!( "   ^    ", add_additional_spaces( p.sv_pct.to_s,  "   ^    " ) )
    end

    set_skater_stats( display, taken_players.select { |pname, p| ["C", "RW", "LW", "D", "LW/RW", "LW/RW", "RW/D", "LW/D"].include?( p.position ) }.values )
    set_goalie_stats( display, taken_players.select { |pname, p| p.position == "G" }.values )

    puts display
  end

  private

  def set_goalie_stats( display, goalies )
    wins = goalies.map( &:wins ).reduce( :+ )
    display.sub!( "@ ", add_additional_spaces( wins.to_s, "@ " ) )

    gaa_collection = goalies.map( &:gaa )
    gaa = ( gaa_collection.reduce( :+ ) / gaa_collection.size )
    display.sub!( "@   ", add_additional_spaces( gaa.to_s, "@   " ) )

    sv_pct_collection = goalies.map( &:sv_pct )
    gaa = sv_pct_collection.reduce( :+ ) / sv_pct_collection.size
    display.sub!( "@   ", add_additional_spaces( sv_pct_collection.to_s, "@   " ) )

    shutouts = goalies.map( &:shutouts ).reduce( :+ )
    display.sub!( "@ ", add_additional_spaces( shutouts.to_s, "@ " ) )
  end

  def set_skater_stats( display, players )
    goals = players.map( &:goals ).reduce( :+ )
    display.sub!( "$  ", add_additional_spaces( goals.to_s, "$  " ) )

    assists = players.map( &:assists ).reduce( :+ )
    display.sub!( "$  ", add_additional_spaces( assists.to_s, "$  " ) )

    ppp = players.map( &:ppp ).reduce( :+ )
    display.sub!( "$  ", add_additional_spaces( ppp.to_s, "$  " ) )

    shp = players.map( &:shp ).reduce( :+ )
    display.sub!( "$ ", add_additional_spaces( shp.to_s, "$ " ) )

    plus_minus = players.map( &:plus_minus ).reduce( :+ )
    display.sub!( "$ ", add_additional_spaces( plus_minus.to_s, "$ " ) )

    sog = players.map( &:sog ).reduce( :+ )
    display.sub!( "$   ", add_additional_spaces( sog.to_s, "$   " ) )

    gwg = players.map( &:gwg ).reduce( :+ )
    display.sub!( "$ ", add_additional_spaces( gwg.to_s, "$ " ) )

    hits = players.map( &:hits ).reduce( :+ )
    display.sub!( "$  ", add_additional_spaces( hits.to_s, "$  " ) )

    fow = players.map( &:fow ).reduce( :+ )
    display.sub!( "$   ", add_additional_spaces( fow.to_s, "$   " ) )
  end

  def add_additional_spaces( name, space )
    if name.length == space.length
      name
    elsif name.length < space.length
      difference = space.length - name.length
      new_name = name + ( " " * difference )
      new_name
    else
      difference = name.length - space.length
      name[0..-(name.length - space.length + 1)]
    end
  end
end


p = Player.new( {rank: 1, player: "The First player", fhg_value: 77, goals: 35, assists: 15,
        sog: 298, ppp: 15, w: " ", shutouts: " ", gaa: " ", sv_pct: " ", fow: 840, shp: 5, 
        gwg: 6, hits: 35, plus_minus: 30, position: "C"} )
p2 = Player.new( {rank: 15, player: "sup", fhg_value: 89, goals: 27, assists: 25,
        sog: 198, ppp: 11, w: " ", shutouts: " ", gaa: " ", sv_pct: " ", fow: 250, shp: 3, 
        gwg: 8, hits: 50, plus_minus: -10, position: "RW"} )
p3 = Player.new( {rank: 90, player: "goalie", fhg_value: 24, goals: " ", assists: " ",
        sog: " ", ppp: " ", w: 9, shutouts: 1, gaa: 2.85, sv_pct: 0.916, fow: " ", shp: " ", 
        gwg: " ", hits: " ", plus_minus: " ", position: "G"} )

PrintFormatter.new.print( {"The first player" => p, "sup" => p2, "goalie" => p3} )

