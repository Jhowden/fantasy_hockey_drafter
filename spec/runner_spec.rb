require "runner"

describe Runner do
  let( :runner ) { described_class.new }
  let( :parser ) { double() }
  let( :print_formatter ) { double( print: nil ) }
  let( :carey ) { double( rank: 50, update_ranking: nil ) }
  let( :carey2 ) { double( rank: 39 ) }
  let( :ovi ) { double( rank: 6, update_ranking: nil ) }
  let( :ovi2 ) { double( rank: 10 ) }
  let( :player_map1 ) { { "Carey Price" => carey, "Alex Ovechkin" => ovi } }
  let( :player_map2 ) { { "Carey Price" => carey2, "Alex Ovechkin" => ovi2 } }

  before :each do
    stub_const "PlayerParser", Class.new
    allow( PlayerParser ).to receive( :new ).and_return PlayerParser
    allow( PlayerParser ).to receive( :parse ).and_return parser
    allow( parser ).to receive( :players ).and_return player_map1, player_map2

    stub_const "PrintFormatter", Class.new
    allow( PrintFormatter ).to receive( :new ).and_return print_formatter

    stub_const "#{described_class}::NOTABLE_PLAYERS", ["Carey Price"]
  end

  it "merges the ranks of the files together" do
    runner

    expect( carey ).to have_received( :update_ranking )
    expect( ovi ).to have_received( :update_ranking )
  end

  it "returns a map of the players" do
    runner

    expect( runner.players_available.keys ).to eq( ["Carey Price", "Alex Ovechkin"] )
  end

  it "returns the notable_players" do
    runner

    expect( runner.notable_players.keys ).to eq( ["Carey Price"] )
    expect( runner.notable_players.values ).to eq( [carey] )
  end

  it "prints out the screen" do
    runner.start_draft!

    expect( print_formatter ).to have_received( :print ).with( 
      runner.players_taken, runner.players_available, runner.notable_players )
  end
end