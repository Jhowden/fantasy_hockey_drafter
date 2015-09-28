require "runner"

describe Runner do
  let( :runner ) { described_class.new }
  let( :parser ) { double() }
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
  end

  it "merges the ranks of the files together" do
    runner

    expect( carey ).to have_received( :update_ranking )
    expect( ovi ).to have_received( :update_ranking )
  end

  it "returns a map of the players" do
    runner

    expect( runner.players.keys ).to eq( ["Carey Price", "Alex Ovechkin"] )
  end

  it ""
end