require "player"
require "player_parser"
require "print_formatter"

class Runner
  attr_reader :players, players_taken

  def initialize()
    @players = {}
    @players_taken = {}
    @draft_over = false
    @print_formatter = PrintFormatter.new

    merge_player_ranking
  end

  def start_draft!()
    while !draft_over do
      print_formatter.print( players_taken )
      # get input about what who is picking
      # set the player to taken
      # loop over until switching to draft over
    end
  end

  private

  def merge_player_ranking()
    three_year_avg_players = PlayerParser.new( three_year_avg_file_path ).parse.players
    last_year_players = PlayerParser.new( last_year_file_path ).parse.players
    player_names = three_year_avg_players.keys
    update_ranking( player_names, three_year_avg_players, last_year_players )
  end

  def update_ranking( player_names, avg_players, last_year_players )
    player_names.each do |name|
      player = avg_players[name]
      player.update_ranking( last_year_players[name].rank )
      players[name] = player
    end
  end

  def three_year_avg_file_path()
    File.expand_path( File.join( File.dirname( __FILE__ ), "..", "The_first_chance_18121.csv" ) )
  end

  def last_year_file_path()
    File.expand_path( File.join( File.dirname( __FILE__ ), "..", "The_Second_Chance_18124.csv" ) )
  end
end