require_relative 'card'
require_relative 'deck'

class Game

  attr_accessor :deck
                :players_hand
                :dealers_hand

  def initialize
    @deck = Deck.new
    @players_hand = deck.card.pop(2)
    @dealers_hand = deck.card.pop(2)
  end

  def play
    puts "Ready to play Blackjack [any key to continue]"
    gets
    @players_hand.each do |card|
      puts "You have a #{card.face} of #{card.suit}"
    end
    puts "Your total is #{player_score}"
    puts "Dealer is showing #{@dealers_hand[0].face} of #{@dealers_hand[0].suit}"
    if player_score < 21
      puts "Do you want to hit (y/n)"
      desire = gets.chomp
        until desire != "y" || player_score >= 21
          player_hit
            @players_hand.each do |card|
              puts "You have a #{card.face} of #{card.suit}"
            end
              puts "Your total is #{player_score}"
                if player_score > 21
                  puts "You Busted!"
                elsif player_score == 21
                  puts = "You Win!"
                else puts "Do you want to hit again (y/n)"
                end
              desire = gets.chomp
        end
        if desire == "n"
          puts "Your total is #{player_score}"
        end
    elsif player_score > 21
      puts "You Bust"
    else player_score == 21
      puts "You Win"
    end

    if player_score > 21 || player_score == 21
      exit
    end

    until dealer_score > 15 || dealer_score > player_score
      dealer_hit
    end
    if dealer_score > 21
      puts "Dealer busted with a score of #{dealer_score}, You Win!"
      exit
    end

    if player_score == dealer_score
      puts "You Win with a score of #{player_score} and a dealer score of #{dealer_score}!"
    elsif player_score > dealer_score
      puts "You Win with a score of #{player_score} and a dealer score of #{dealer_score}!"
    elsif player_score < dealer_score
      puts "You Lose with a score of #{player_score} and a dealer score of #{dealer_score}!"

    end

  end



  def player_hit
    @players_hand << deck.card.pop
  end

  def dealer_hit
    @dealers_hand << deck.card.pop
  end

  def player_score
    @players_hand.inject(0) {|sum, card| sum + card.value}
  end

  def dealer_score
    @dealers_hand.inject(0) {|sum, card| sum + card.value}
  end

end

game = Game.new
game.play
