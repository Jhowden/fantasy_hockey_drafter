class InputSelector

  def selection( players_available, players_taken )
    input = user_input

    if input.start_with? "> "
      name = input.gsub( "> ", "" )
      players_available[name].drafted!
      players_taken[name] = players_available[name]
    elsif players_available[input]
      players_available[input].drafted!
    else
      puts "Mistyped the player's name"
    end

    players_taken
  end

  private

  def user_input
    print "> "
    gets.chomp
  end
end