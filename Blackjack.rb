require_relative 'card'
require_relative 'deck'
require 'io/console'
# even more stuff
class Game

  attr_accessor :deck,
                :players_hand,
                :dealers_hand,
                :players_score,
                :dealers_score

  def initialize
    @deck = Deck.new
    @players_hand = deck.card.pop(2)
    @dealers_hand = deck.card.pop(2)
    @players_score = 0 #Added as an idea for tracking win counts for multiple games (need a restart method to do so)
    @dealers_score = 0 #Added as an idea for tracking win counts for multiple games (need a restart method to do so)
  end

  #Show player hands before the
  def show_hands_initial
    puts "\nYour hand (#{player_hand_total}):" #\n creates a new line. makes the command line text easier to read
    players_hand.each do |card|
      puts "\t#{card.face} of #{card.suit}" #\t indents the given text. not necessary, just easier to read/play
    end
    puts "\nDealer is showing #{dealers_hand[0].face} of #{dealers_hand[0].suit}"
  end

  def show_hands_final
    puts "\nYour hand (#{player_hand_total}):"
    players_hand.each do |card|
      puts "\t#{card.face} of #{card.suit}"
    end
    puts "\nDealer's hand (#{dealer_hand_total}):"
    dealers_hand.each do |card|
      puts "\t#{card.face} of #{card.suit}"
    end
  end

  def play
    puts "Ready to play Blackjack [press any key to continue]"
    STDIN.getch #get character without return. not necessary, just nice and fun
    show_hands_initial
    player_turn
  end

  def player_turn
    if player_hand_total < 21
      puts "\nDo you want to hit (y/n)\n"
      desire = STDIN.getch #get character
      if desire == "y" #works without accounting for an "n" response. Goes to dealer turns otherwise
        player_hit
        show_hands_initial
        player_turn #loop via recursion :-) loops back from here to the top (calling player_turn)
        #until the player's hand is > or = 21 or the user his something other than "y"
      elsif desire == "n"
        dealer_turn
      else
        puts "\nYou provided #{desire}. Please provide 'y' or 'n'." #Mistakes happen. Gives the user another try
        show_hands_initial #show hands again so the user doesn't have to look up too far
        player_turn #gives the user another shot to prevent sausage finger mistakes, via recursion
      end
    elsif player_hand_total > 21
      puts "\nYou bust, dealer wins."
      show_hands_final
      self.dealers_score += 1
      score
      replay
    elsif player_hand_total == 21
      puts "\n#{player_hand_total}, you win!"
      show_hands_final
      self.players_score += 1
      score
      replay
    end
  end

  def dealer_turn
    until dealer_hand_total > 15
      dealer_hit
    end
    show_hands_final
    if dealer_hand_total > 21
      puts "\nDealer busted with a score of #{dealer_hand_total}, You Win!"
    end
    declare_winner
  end

  def declare_winner
    if player_hand_total == dealer_hand_total
      puts "\nYou Win with a score of #{player_hand_total} and a dealer score of #{dealer_hand_total}!"
      self.players_score += 1
      score
    elsif dealer_hand_total > 21 || player_hand_total > dealer_hand_total
      puts "\nYou Win with a score of #{player_hand_total} and a dealer score of #{dealer_hand_total}!"
      self.players_score += 1
      score
    elsif player_hand_total < dealer_hand_total
      puts "\nYou Lose with a score of #{player_hand_total} and a dealer score of #{dealer_hand_total}!"
      self.dealers_score += 1
      score
    end
    replay
  end

  #Added as an idea for tracking win count for multiple games (need a restart method to do so)
  def score
    puts "\n---PLAYER 1: #{self.players_score} -- DEALER: #{self.dealers_score}---"
  end

  def replay
    puts "Do you want to play again (y/n)"
    desire = gets.chomp

    if desire == "y"
      @deck = Deck.new
      @players_hand = deck.card.pop(2)
      @dealers_hand = deck.card.pop(2)
      self.play
    elsif desire == "n"
      exit
    else
      puts "Please answer with y or n"
      replay
    end
  end

  def player_hit
    players_hand << deck.card.pop
  end

  def dealer_hit
    dealers_hand << deck.card.pop
  end

  #Changed method name to not confuse with the number of wins type of score
  def player_hand_total
    players_hand.inject(0) {|sum, card| sum + card.value}
  end

  #Changed method name to not confuse with the number of wins type of score
  def dealer_hand_total
    dealers_hand.inject(0) {|sum, card| sum + card.value}
  end

end

game = Game.new
game.play
