require_relative "player"

class PrintFormatter
  attr_reader :notable_players

  def print( taken_players, available_players, notable_players )
    display = DISPLAY.dup
    taken_players.each do |pname, p|
      display.sub!( "     *                    ", add_additional_spaces( pname, "     *                    " ) )
      display.sub!( "      *      ", add_additional_spaces( p.position, "      *      " ) )
    end

    available_players.reject{ |pname, p| p.taken }.each do |pname, p|
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

    notable_players.reject{ |pname, p| p.taken }.each do |pname, p|
      display.sub!( "    &                     ", add_additional_spaces( p.player,  "    &                     " ) )
      display.sub!( "    &     ", add_additional_spaces( p.position,  "    &     " ) )
      display.sub!( "  &   ", add_additional_spaces( p.fhg_value.to_s,  "  &   " ) )
      display.sub!( " & ", add_additional_spaces( p.goals.to_s,  " & " ) )
      display.sub!( " & ", add_additional_spaces( p.assists.to_s,  " & " ) )
      display.sub!( "  &  ", add_additional_spaces( p.sog.to_s,  "  &  " ) )
      display.sub!( "  &  ", add_additional_spaces( p.ppp.to_s,  "  &  " ) )
      display.sub!( "  &  ", add_additional_spaces( p.shp.to_s,  "  &  " ) )
      display.sub!( "  &  ", add_additional_spaces( p.plus_minus.to_s,  "  &  " ) )
      display.sub!( "  &  ", add_additional_spaces( p.gwg.to_s,  "  &  " ) )
      display.sub!( "  &   ", add_additional_spaces( p.hits.to_s,  "  &   " ) )
      display.sub!( "  &  ", add_additional_spaces( p.fow.to_s,  "  &  " ) ) 
      display.sub!( " ? ", add_additional_spaces( p.wins.to_s,  " ? " ) )
      display.sub!( " ?  ", add_additional_spaces( p.shutouts.to_s,  " ?  " ) )
      display.sub!( "  ?  ", add_additional_spaces( p.gaa.to_s,  "  ?  " ) )
      display.sub!( "   ?    ", add_additional_spaces( p.sv_pct.to_s,  "   ?    " ) )
    end

    set_skater_stats( display, taken_players.select { |pname, p| ["C", "RW", "LW", "D", "LW/RW", "LW/RW", "RW/D", "LW/D"].include?( p.position ) }.values )
    set_goalie_stats( display, taken_players.select { |pname, p| p.position == "G" }.values )

    puts display
  end

  private

  def set_goalie_stats( display, goalies )
    return if goalies.size == 0
    wins = goalies.map( &:wins ).reduce( 0, :+ )
    display.sub!( "@ ", add_additional_spaces( wins.to_s, "@ " ) )

    gaa_collection = goalies.map( &:gaa )
    gaa = ( gaa_collection.reduce( 0, :+ ) / gaa_collection.size )
    display.sub!( "@   ", add_additional_spaces( gaa.to_s, "@   " ) )

    sv_pct_collection = goalies.map( &:sv_pct )
    gaa = sv_pct_collection.reduce( 0, :+ ) / sv_pct_collection.size
    display.sub!( "@    ", add_additional_spaces( gaa.to_s, "@    " ) )

    shutouts = goalies.map( &:shutouts ).reduce( 0, :+ )
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

  DISPLAY = <<-STRING
+----------------------------------------+-----+-----+-------------------------------------------------------------------------------------------------------------------+
|        TAKEN PLAYERS     |             |  |  |                                  TOP_AVAILABLE_PLAYERS                                                                  |
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
|                                                                     STATISTICS                                                                                         |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|                               GOALS: $  /233            ASSISTS: $  /427                 PPP: $  /215           SHP: $ /13        PLUS/MINUS: $ /72                    |
|                SOG: $   /2267                 GWG: $ /41                  HITS: $  /969              FOW: $   /2382                                                    |
|                                                                                                                                                                        |
|               WINS: @ /75                GAA: @   /2.36             SV_PCT: @    /0.920          SHUTOUTS: @ /11                                                       |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|                                        NOTABLE_PLAYERS                                                                  |                                              |
+----------------------------+----------+------+---+---+-----+-----+-----+-----+-----+------+-----+---+----+-----+--------+----------------------------------------------+
|  NAME                      | POSTIION | FHGV | G | A | SOG | PPP | SHP | +/- | GWG | HITS | FOW | W | SO | GAA | SV_PCT |                                              |
+----------------------------+----------+------+---+---+-----+-----+-----+-----+-----+------+-----+---+----+-----+--------+----------------------------------------------+
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
|    &                       |    &     |  &   | & | & |  &  |  &  |  &  |  &  |  &  |  &   |  &  | ? | ?  |  ?  |   ?    |                                              |
-----------------------------+----------+------+---+---+-----+-----+-----+-----+-----+------+-----+---+----+-----+--------+----------------------------------------------+
STRING
end