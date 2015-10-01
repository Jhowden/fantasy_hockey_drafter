require "./lib/player"
require "./lib/player_parser"
require "./lib/print_formatter"
require "./lib/input_selector"

class Runner
  NOTABLE_PLAYERS = ["Vladimir Tarasenko", "Braden Holtby", "Filip Forsberg", "Ryan Strome", "Nikita Kucherov", 
    "Johnny Gaudreau", "Valeri Nichushkin", "Blake Wheeler", "Teuvo Teravainen", "Sam Bennett", 
    "Sean Monahan", "Evgeny Kuznetsov", "Matt Dumba", "Anders Lee", "Marko Dano"]

  attr_reader :players_available, :players_taken, :notable_players, :print_formatter, :input_selector, :draft_over

  def initialize()
    @players_available = {}
    @players_taken = {}
    @notable_players = {}
    @draft_over = false
    @print_formatter = PrintFormatter.new
    @input_selector = InputSelector.new

    merge_player_ranking
    set_notable_players
  end

  def start_draft!()
    while !draft_over do
      print_formatter.print( players_taken, players_available, notable_players )
      taken_players = input_selector.selection( players_available, players_taken )

      if taken_players.keys.size >= 16
        @draft_over = true
      end
    end
  end

  private

  def merge_player_ranking()
    three_year_avg_parser = PlayerParser.new( three_year_avg_file_path )
    three_year_avg_parser.parse
    last_year_parser = PlayerParser.new( last_year_file_path )
    last_year_parser.parse
    player_names = three_year_avg_parser.players.keys
    update_ranking( player_names, three_year_avg_parser.players, last_year_parser.players )
  end

  def set_notable_players()
    NOTABLE_PLAYERS.each do |player_name|
      notable_players[player_name] = players_available[player_name]
    end
  end

  def update_ranking( player_names, avg_players, last_year_players )
    player_names.each do |name|
      player = avg_players[name]
      player.update_ranking( last_year_players[name].rank )
      players_available[name] = player
    end
  end

  def three_year_avg_file_path()
    File.expand_path( File.join( File.dirname( __FILE__ ), "..", "The_first_chance_18121.csv" ) )
  end

  def last_year_file_path()
    File.expand_path( File.join( File.dirname( __FILE__ ), "..", "The_Second_Chance_18124.csv" ) )
  end
end