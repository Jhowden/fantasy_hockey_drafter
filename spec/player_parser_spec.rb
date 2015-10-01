require "player_parser"

describe PlayerParser do

  let( :path ) { File.expand_path( File.join( File.dirname( __FILE__ ), "resources", "test_players.csv" ) ) }
  let( :parser ) { described_class.new( path ) }
  let( :price ) { double( player: "Carey Price") }
  let( :ovi ) { double( player: "Alex Ovechkin" ) }

  before :each do
    stub_const "Player", Class.new
    allow( Player ).to receive( :new ).and_return( price, ovi )
  end

  describe "#parse" do
    it "calls the freaking parser" do
      allow( CSV ).to receive( :foreach )

      parser.parse

      expect( CSV ).to have_received( :foreach ).with( path, headers: true )
    end

    it "creates a player" do
      parser.parse

      expect( Player ).to have_received( :new ).with( 
        {
          rank: 1, 
          player: "Carey Price",
          team: "MTL",
          position: "G",
          fhg_value: 198,
          games_played: 59,
          sv_pct: 0.925,
          gaa: 2.21,
          wins: 98,
          shutouts: 18
        }
      )

      expect( Player ).to have_received( :new ).with( 
        {
          rank: 2, 
          player: "Alex Ovechkin",
          team: "WSH",
          position: "LW/RW",
          fhg_value: 180,
          games_played: 80,
          goals: 45,
          assists: 39,
          plus_minus: -9,
          sog: 388,
          gwg: 9,
          ppp: 39,
          shp: 0,
          hits: 226,
          fow: 1
        }
      )
    end

    it "stores the players" do
      parser.parse

      carey = parser.players.fetch "Carey Price"
      alex = parser.players.fetch "Alex Ovechkin"

      expect( parser.players ).to eq( { "Carey Price" => carey, "Alex Ovechkin" => alex } )
    end
  end
end