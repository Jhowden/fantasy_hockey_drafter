require "runner"

describe Runner do
  let( :runner ) { described_class.new }
  let( :parser ) { double( "parser", parse: nil ) }
  let( :print_formatter ) { double( "print_formatter", print: nil ) }
  let( :carey ) { double( "carey", rank: 50, update_ranking: nil ) }
  let( :carey2 ) { double( "carey2", rank: 39 ) }
  let( :ovi ) { double( "ovi", rank: 6, update_ranking: nil ) }
  let( :ovi2 ) { double( "ovi2", rank: 10 ) }
  let( :player_map1 ) { { "Carey Price" => carey, "Alex Ovechkin" => ovi } }
  let( :player_map2 ) { { "Carey Price" => carey2, "Alex Ovechkin" => ovi2 } }
  let( :input_selector ) { double( "input_selector" ) }

  before :each do
    stub_const "PlayerParser", Class.new
    allow( PlayerParser ).to receive( :new ).and_return parser
    allow( parser ).to receive( :parse )
    allow( parser ).to receive( :players ).and_return player_map1, player_map1, player_map2

    stub_const "PrintFormatter", Class.new
    allow( PrintFormatter ).to receive( :new ).and_return print_formatter

    stub_const "#{described_class}::NOTABLE_PLAYERS", ["Carey Price"]

    stub_const "InputSelector", Class.new
    allow( InputSelector ).to receive( :new ).and_return input_selector
    allow( input_selector ).to receive( :selection ).and_return taken_players_map
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

    expect( print_formatter ).to have_received( :print ).
      with( runner.players_taken, runner.players_available, runner.notable_players )
  end

  it "asks for the input" do
    runner.start_draft!

    expect( input_selector ).to have_received( :selection ).
      with( runner.players_available, runner.players_taken )
  end

  it "ends the draft when 16 players have been taken" do
    runner.start_draft!

    expect(  runner.start_draft! ).to be_falsey
  end

  def taken_players_map()
    m = {}
    16.times do |t|
      m["p#{t}"] = t
    end
    m
  end
end