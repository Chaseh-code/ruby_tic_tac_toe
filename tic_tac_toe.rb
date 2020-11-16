#When they start the game tell them the rules of the game. Ask for the name of player1 and player2.
#Ask for player1 input on my array. Sanitize user input
#check if there is a winner.
#display the board using dotted lines and new lines
#Ask for player2 input on my array. Sanitize user input.
#check if there is a winner
#display the board using botted lines and new lines
#if there is a winner, declare which player is the winner.
#keep track of how many wins each player gets and how many ties there are.
#Ask the players if they want to play again.
#rinse repeat until the players type stop.
class Game
    attr_reader :player1, :player2
    attr_accessor :current_player, :other_player, :board, :scoreboard

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @current_player = player1
        @other_player = player2
        @board = Board.new()
        @scoreboard = Scoreboard.new(player1,player2)
    end

    def play
        loop do
            board.display
            placeToken
            if winner?
                puts "\nThe Winner is #{current_player.name}!\n"  
                current_player == player1 ? scoreboard.player1_wins += 1 : scoreboard.player2_wins +=1 
                scoreboard.display
                board.display
                #add some kind of counter that will get passed to the scoreboard class for number of wins
                break
            end
            if board.board.include?('_') != true
                puts "\nThe game is a tie! No one wins"
                scoreboard.ties +=1
                scoreboard.display
                board.display
                #add some kind of counter that will get passed to the scoreboard class for number of ties
                
                break
            end
            switchPlayers
        end

        if playAgain?  
            @board = Board.new()
            play()
        else
            puts "\nThanks for playing!"
            scoreboard.display
            #show results from the scoreboard again
        end

    end

    def switchPlayers
        hold = @current_player
        @current_player = @other_player
        @other_player = hold
    end

    def placeToken
        loop do
            puts "\nPlease pick an open spot between 1-9 to place your token"
            place = gets.chomp.to_i
            if board.board[place-1] == "_"
                board.board[place-1] = current_player.token
                break
            else
                puts "That is not an open spot."
            end
        end
    end

    def winner?
        #Horizontal part of the board
        if ( (board.board[0] == current_player.token) && (board.board[1] == current_player.token) && (board.board[2] == current_player.token) )
            return true
        elsif ( (board.board[3] == current_player.token) && (board.board[4] == current_player.token) && (board.board[5] == current_player.token) )
            return true
        elsif ( (board.board[6] == current_player.token) && (board.board[7] == current_player.token) && (board.board[8] == current_player.token) )
            return true
        #vertical part of the board
        elsif ( (board.board[0] == current_player.token) && (board.board[3] == current_player.token) && (board.board[6] == current_player.token) )
            return true
        elsif ( (board.board[1] == current_player.token) && (board.board[4] == current_player.token) && (board.board[7] == current_player.token) )
            return true
        elsif ( (board.board[2] == current_player.token) && (board.board[5] == current_player.token) && (board.board[8] == current_player.token) )
            return true
        #diagonal part of the board
        elsif ( (board.board[0] == current_player.token) && (board.board[4] == current_player.token) && (board.board[8] == current_player.token) )
            return true
        elsif ( (board.board[2] == current_player.token) && (board.board[4] == current_player.token) && (board.board[6] == current_player.token) )
            return true
        end
    end

    def playAgain?
        puts "\nDo you want to play again? (Y/N)"
        answer = gets.chomp
        if answer.upcase != 'Y' && answer.upcase != 'YES' && answer.upcase != 'N' && answer.upcase != 'NO'
            loop do
                puts "Sorry that is a invalid response. Please enter either (Y/N) or (Yes/No)"
                answer = gets.chomp
                if answer.upcase == 'Y' || answer.upcase == 'YES' || answer.upcase == 'N' || answer.upcase == 'NO'
                    break
                end
            end
        end
        (answer.upcase == 'Y' || answer.upcase == 'YES') ? true : false
    end
end

class Board
    attr_accessor :board

    def initialize()
        @board = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
    end

    def display
        board.length.times do |i|
            case 
                when i==0
                    print "\n" + board[i] + ' '
                when i==2
                    puts board[i] 
                when i==5
                    puts board[i] 
                when i==8
                    puts board[i] 
                else
                    print board[i] + ' '
            end
        end
    end
end

class Player
    attr_reader :name, :token
    def initialize(name, token)
        @name = name
        @token = token
    end
end

class Scoreboard
    attr_accessor :player1, :player2, :player1_wins, :player2_wins, :ties
    def initialize(player1,player2)
        @player1 = player1
        @player2 = player2
        @player1_wins = 0
        @player2_wins = 0
        @ties = 0
    end

    def display
        puts "\n*******SCOREBOARD*********\n"
        puts "#{player1.name} has #{player1_wins} wins!"
        puts "#{player2.name} has #{player2_wins} wins!"
        puts "There has been #{ties} many ties! You all need to practice some tic tac toe lol XD\n"
    end
end


puts "Enter player 1's name"
player_1 = Player.new(gets.chomp, "X")
puts "Enter player 2's name"
player_2 = Player.new(gets.chomp, "O")
game = Game.new(player_1, player_2) 
game.play