require "input_selector"

describe InputSelector do 
  let( :input_selector ) { described_class.new }
  let( :player ) { double( drafted!: nil ) }
  let( :taken_players ) { {} }
  let( :available_players ) { {"Vladimir Tarasenko" => player } }

  before :each do
    allow( STDOUT ).to receive( :puts )
  end

  describe "#selection" do
    it "sets the player to taken when someone else picks" do
      allow( input_selector ).to receive( :gets ).and_return "Vladimir Tarasenko" 

      input_selector.selection( {"Vladimir Tarasenko" => player }, {} )

      expect( player ).to have_received( :drafted! )
    end

    it "moves the player into taken if it is player's pick" do
      allow( input_selector ).to receive( :gets ).and_return "> Vladimir Tarasenko"

      input_selector.selection( available_players, taken_players )

      expect( taken_players["Vladimir Tarasenko"] ).to eq player
    end

    it "does nothing if the player doesn't exist" do
      allow( input_selector ).to receive( :gets ).and_return "Vladimir Tarasenkodafdsa" 

      input_selector.selection( {"Vladimir Tarasenko" => player }, {} )

      expect( player ).to_not have_received( :drafted! )
    end

    it "returns the taken players" do
      allow( input_selector ).to receive( :gets ).and_return "> Vladimir Tarasenko" 

      expect( input_selector.selection( {"Vladimir Tarasenko" => player }, {} ) ).to eq( {"Vladimir Tarasenko" => player } )
    end
  end
end