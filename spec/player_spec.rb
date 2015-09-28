require "player"

describe Player do
  let( :player ) { described_class.new( {rank: 10} ) }

  describe "#drafted!" do
    it "returns true when the player is taken" do
      expect( player.taken ).to_not be

      player.drafted!

      expect( player.taken ).to be
    end
  end

  describe "#update_ranking" do
    it "averages the ranking" do
      player.update_ranking( 6 )

      expect( player.rank ).to eq 8.0
    end

    it "averages the ranking as a float" do
      player.update_ranking( 5 )

      expect( player.rank ).to eq 7.5
    end
  end
end