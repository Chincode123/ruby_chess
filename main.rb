require_relative "pieces.rb"
require_relative "draw.rb"

# Beskrivning: Returnerar hur många poäng en pjäs är värd
# Argument 1: Piece - pjäsen som ska undersökas
# Return: 
#       Integer - poängvärdet av pjäsen
#       nil - inte en gjlitig pjäs
# Exempel:
#       piece_to_points(Pawn) => 1
#       piece_to_points(Knight) => 3
#       piece_to_points(Bishop) => 3
#       piece_to_points(Rook) => 5
#       piece_to_points(Queen) => 9
#       piece_to_points(Piece) => nil
# Noah Westerberg
# Datum 4/5/2024
def piece_to_points(piece)
    if piece.class == Pawn
        return 1
    elsif piece.class == Knight || piece.class == Bishop
        return 3
    elsif piece.class == Rook
        return 5
    elsif piece.class == Queen
        return 9
    end
end

Player = Struct.new(:name, :color) do
    # Beskrivning: Returnerar hur många poäng spelaren har
    # Argument 1: Array - Spelbrädan
    # Return: Integer - antal poäng som spelaren har
    # Datum 5/5/2024
    # Namn: Noah Westerberg
    def points(board)
        points = 0
        for row in board
            for piece in row
                if piece.class != Empty && piece.class != En_passant_square
                    if piece.color == color
                        piece_points = piece_to_points(piece)
                        if piece_points != nil
                            points += piece_points
                        end
                    end
                end
            end
        end
        return points
    end
end

# Beskrivning: Initializera spelarna
# Return: Array - spelarna
# Exempel:
#   initialize_players() => [
#       #<struct Player name="Player 1", color="white">, 
#       #<struct Player name="Player 2", color="black">]
# Datum: 5/5/2024
# Namn: Noah Westerberg
def initialize_players()
    player1 = Player.new("Player 1", "white")
    player2 = Player.new("Player 2", "black")
    return [player1, player2]
end

# Beskrivning: Initializerar spelbrädan
# Return Array - spelbrädan
# Exempel: 
#       initialize_board() => [[#<Rook:0x0000029b2c237228 @icon="R", @color="white", @position=#<struct Vector2 x=0, y=0>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c236ff8 @icon="Kn", @color="white", @position=#<struct Vector2 x=1, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236f58 @icon="B", @color="white", @position=#<struct Vector2 x=2, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Queen:0x0000029b2c236e18 @icon="Q", @color="white", @position=#<struct Vector2 x=3, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<King:0x0000029b2c236eb8 @icon="K", @color="white", @position=#<struct Vector2 x=4, y=0>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236f08 @icon="B", @color="white", @position=#<struct Vector2 x=5, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c236fa8 @icon="Kn", @color="white", @position=#<struct Vector2 x=6, y=0>, @targeted_by_white=false, @targeted_by_black=false>, #<Rook:0x0000029b2c237048 @icon="R", @color="white", @position=#<struct Vector2 x=7, y=0>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>], [#<Pawn:0x0000029b2c236d78 @icon="P", @color="white", @position=#<struct Vector2 x=0, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236d28 @icon="P", @color="white", @position=#<struct Vector2 x=1, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236c88 @icon="P", @color="white", @position=#<struct Vector2 x=2, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236c38 @icon="P", @color="white", @position=#<struct Vector2 x=3, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236be8 @icon="P", @color="white", @position=#<struct Vector2 x=4, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236b98 @icon="P", @color="white", @position=#<struct Vector2 x=5, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236af8 @icon="P", @color="white", @position=#<struct Vector2 x=6, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>, #<Pawn:0x0000029b2c236aa8 @icon="P", @color="white", @position=#<struct Vector2 x=7, y=1>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=1>], [#<Empty:0x0000029b2c0fc520 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc3b8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc318 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc228 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fc160 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbf80 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbee0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbe18 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Empty:0x0000029b2c0fbda0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbc60 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbb48 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fbaa8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fba30 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb918 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb878 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb800 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Empty:0x0000029b2c0fb760 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb6c0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb5f8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb580 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb508 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb490 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb418 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb3a0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Empty:0x0000029b2c0fb328 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb288 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb1c0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb0f8 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fb080 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0fafe0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0faf68 @icon="#", @targeted_by_white=false, @targeted_by_black=false>, #<Empty:0x0000029b2c0faef0 @icon="#", @targeted_by_white=false, @targeted_by_black=false>], [#<Pawn:0x0000029b2c2360f8 @icon="P", @color="black", @position=#<struct Vector2 x=0, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c2360a8 @icon="P", @color="black", @position=#<struct Vector2 x=1, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c236008 @icon="P", @color="black", @position=#<struct Vector2 x=2, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235fb8 @icon="P", @color="black", @position=#<struct Vector2 x=3, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235f18 @icon="P", @color="black", @position=#<struct Vector2 x=4, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235ec8 @icon="P", @color="black", @position=#<struct Vector2 x=5, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235e28 @icon="P", @color="black", @position=#<struct Vector2 x=6, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>, #<Pawn:0x0000029b2c235dd8 @icon="P", @color="black", @position=#<struct Vector2 x=7, y=6>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false, @direction=-1>], [#<Rook:0x0000029b2c2365f8 @icon="R", @color="black", @position=#<struct Vector2 x=0, y=7>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c236558 @icon="Kn", @color="black", @position=#<struct Vector2 x=1, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236468 @icon="B", @color="black", @position=#<struct Vector2 x=2, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Queen:0x0000029b2c236148 @icon="Q", @color="black", @position=#<struct Vector2 x=3, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<King:0x0000029b2c2361e8 @icon="K", @color="black", @position=#<struct Vector2 x=4, y=7>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>, #<Bishop:0x0000029b2c236238 @icon="B", @color="black", @position=#<struct Vector2 x=5, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Knight:0x0000029b2c2364b8 @icon="Kn", @color="black", @position=#<struct Vector2 x=6, y=7>, @targeted_by_white=false, @targeted_by_black=false>, #<Rook:0x0000029b2c2365a8 @icon="R", @color="black", @position=#<struct Vector2 x=7, y=7>, @has_moved=false, @targeted_by_white=false, @targeted_by_black=false>]]
# Datum 5/5/2024
# Namn: Noah Westerberg
def initialize_board()
    board = [
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],        
        [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new]
    ]


    
    # Normal setup:

    # white pieces
    board[0][0] = Rook.new(Vector2.new(0, 0), "white")
    board[0][7] = Rook.new(Vector2.new(7, 0), "white")
    board[0][1] = Knight.new(Vector2.new(1, 0), "white")
    board[0][6] = Knight.new(Vector2.new(6, 0), "white")
    board[0][2] = Bishop.new(Vector2.new(2, 0), "white")
    board[0][5] = Bishop.new(Vector2.new(5, 0), "white")
    board[0][4] = King.new(Vector2.new(4, 0), "white")
    board[0][3] = Queen.new(Vector2.new(3, 0), "white")
    board[1][0] = Pawn.new(Vector2.new(0, 1), "white")
    board[1][1] = Pawn.new(Vector2.new(1, 1), "white")
    board[1][2] = Pawn.new(Vector2.new(2, 1), "white")
    board[1][3] = Pawn.new(Vector2.new(3, 1), "white")
    board[1][4] = Pawn.new(Vector2.new(4, 1), "white")
    board[1][5] = Pawn.new(Vector2.new(5, 1), "white")
    board[1][6] = Pawn.new(Vector2.new(6, 1), "white")
    board[1][7] = Pawn.new(Vector2.new(7, 1), "white")
    # black pieces
    board[7][0] = Rook.new(Vector2.new(0, 7), "black")
    board[7][7] = Rook.new(Vector2.new(7, 7), "black")
    board[7][1] = Knight.new(Vector2.new(1, 7), "black")
    board[7][6] = Knight.new(Vector2.new(6, 7), "black")
    board[7][2] = Bishop.new(Vector2.new(2, 7), "black")
    board[7][5] = Bishop.new(Vector2.new(5, 7), "black")
    board[7][3] = Queen.new(Vector2.new(3, 7), "black")
    board[7][4] = King.new(Vector2.new(4, 7), "black")
    board[6][0] = Pawn.new(Vector2.new(0, 6), "black")
    board[6][1] = Pawn.new(Vector2.new(1, 6), "black")
    board[6][2] = Pawn.new(Vector2.new(2, 6), "black")
    board[6][3] = Pawn.new(Vector2.new(3, 6), "black")
    board[6][4] = Pawn.new(Vector2.new(4, 6), "black")
    board[6][5] = Pawn.new(Vector2.new(5, 6), "black")
    board[6][6] = Pawn.new(Vector2.new(6, 6), "black")
    board[6][7] = Pawn.new(Vector2.new(7, 6), "black")

    # Showcase:
    
    # En passant:
    # board[0][4] = King.new(Vector2.new(4, 0), "white")
    # board[7][4] = King.new(Vector2.new(4, 7), "black")
    # board[1][3] = Pawn.new(Vector2.new(3, 1), "white")
    # board[3][4] = Pawn.new(Vector2.new(4, 3), "black")
    
    # Promotion:
    # board[0][4] = King.new(Vector2.new(4, 0), "white")
    # board[7][4] = King.new(Vector2.new(4, 7), "black")
    # board[5][7] = Pawn.new(Vector2.new(7, 5), "white")

    # Castling:
    # board[0][4] = King.new(Vector2.new(4, 0), "white")
    # board[7][4] = King.new(Vector2.new(4, 7), "black")
    # board[7][0] = Rook.new(Vector2.new(0, 7), "black")
    # board[7][7] = Rook.new(Vector2.new(7, 7), "black")
    # board[0][0] = Rook.new(Vector2.new(0, 0), "white")
    # board[0][7] = Rook.new(Vector2.new(7, 0), "white")

    # check:
    # board[0][0] = King.new(Vector2.new(0, 0), "white")
    # board[4][3] = King.new(Vector2.new(3, 4), "black")
    # board[5][2] = Pawn.new(Vector2.new(2, 5), "black")
    # board[4][2] = Pawn.new(Vector2.new(2, 4), "black")
    # board[4][4] = Pawn.new(Vector2.new(4, 4), "black")
    # board[5][3] = Pawn.new(Vector2.new(3, 5), "black")
    # board[5][4] = Pawn.new(Vector2.new(4, 5), "black")
    # board[3][2] = Pawn.new(Vector2.new(2, 3), "black")
    # board[3][3] = Pawn.new(Vector2.new(3, 3), "black")
    # board[1][4] = Bishop.new(Vector2.new(4, 1), "white")
    
    # checkmate:
    # board[0][4] = King.new(Vector2.new(4, 0), "white")
    # board[7][0] = King.new(Vector2.new(0, 7), "black")
    # board[1][1] = Rook.new(Vector2.new(1, 1), "white")
    # board[6][5] = Queen.new(Vector2.new(5, 6), "white")
    
    # Stalemate:
    # board[0][4] = King.new(Vector2.new(4, 0), "white")
    # board[7][0] = King.new(Vector2.new(0, 7), "black")
    # board[1][1] = Rook.new(Vector2.new(1, 1), "white")
    # board[1][2] = Rook.new(Vector2.new(2, 1), "white")
    
    return board
end

# Beskrivning: Omvandlar en rutbetäckning till cordinater
# Argument 1: String - rutbetöckning
# Return: 
#       Vector2 - cordinater
#       nil: felaktig input
# Exempel:
#       square_to_coordinets("a1") => (0, 0)
#       square_to_coordinets("h8") => (7, 7) 
#       square_to_coordinets("e4") => (4, 4)     
#       square_to_coordinets("E4") => (4, 4) 
#       square_to_coordinets("N2") => nil
#       square_to_coordinets("cb") => nil
#       square_to_coordinets("d0") => nil
# Datum: 2/5/2024
# Namn: Noah Westerberg
def square_to_coordinets(square)
    if (square.length < 2)
        return nil
    end
    
    x = 0
    y = square[1].to_i - 1 
    if y < 0
        return nil
    end
    column = square[0].downcase
    if column == "a"
        x = 0
    elsif column == "b"
        x = 1
    elsif column == "c"
        x = 2
    elsif column == "d"
        x = 3
    elsif column == "e"
        x = 4
    elsif column == "f"
        x = 5
    elsif column == "g"
        x = 6
    elsif column == "h"
        x = 7
    else
        return nil
    end

    return Vector2.new(x, y)
end

# Beskrivning: Omvandlar kordinater till rutbetäckning
# Argument 1: Vector2 - Rutans position
# Return: 
#       String - Rutans betäckning
#       nil - felaktig input
# Exempel:
#       coordinets_to_square(Vector2.new(0, 0)) => a1
#       coordinets_to_square(Vector2.new(7, 7)) => h8
#       coordinets_to_square(Vector2.new(235, 635)) => nil
# Datum: 6/5/2024
# Namn: Noah Westerberg
def coordinets_to_square(coordinets)
    square = ""
    if coordinets.x == 0
        square.concat("a")
    elsif coordinets.x == 1
        square.concat("b")
    elsif coordinets.x == 2
        square.concat("c")
    elsif coordinets.x == 3
        square.concat("d")
    elsif coordinets.x == 4
        square.concat("e")
    elsif coordinets.x == 5
        square.concat("f")
    elsif coordinets.x == 6
        square.concat("g")
    elsif coordinets.x == 7
        square.concat("h")
    end
    square.concat("#{coordinets.y + 1}")
    if square.length == 2
        return square
    else
        return nil
    end
end

# Beskrivning: Input-function som letear efter oavgjort
# Argument 1: String - output sträng där inputen går till om det inte blir oavgjort
# Return: Bolean - true om det ska bli oavgjort, annars false
# Exempel:
#       get_input(), användaren skriver "a1", => false
#       get_input(), användaren skriver "f3", => false
#       get_input(), användaren skriver "draw" => true
#       get_input(), användaren skriver "" => false
# Datum 5/5/2024
# Namn: Noah Westerberg
def get_input(out)
    input = gets.chomp
    if input.downcase == "draw"
        puts "To confirm the DRAW type \"draw\" again"
        input = gets.chomp
        if input.downcase == "draw"
            return true
        end
        puts "DRAW faild"
    end
    i = 0
    while i < out.length
        out.slice!(i)
    end
    out.concat(input)
    return false
end

# Beskrivning: Input function för att få kordinaterna för en ruta. Functionen har validering så att det bara går att skriva in giltiga inputs. Functionen är recursiv
# Return: 
#       Vector2 - cordinaterna för rutan som är vald
#       String - "draw" för att aktivera att det blir oavgjort
#       nil - Inget anges
# Exempel:
#       input_square(), användaren skriver "a1", => square_to_cordinets(a1) => <struct Vector2 x=0, y=0>
#       input_square(), användaren skriver "f3", => square_to_cordinets(f3) => <struct Vector2 x=5, y=4>
#       input_square(), användaren skriver "draw" => "draw"
#       input_square(), användaren skriver "" => nil
# Datum: 5/5/2024
# Namn: Noah Westerberg
def input_square()
    input = ""
    if get_input(input)
        return "draw"
    elsif input == ""
        return nil
    elsif input.length != 2
        puts "Invalid input: Your input:\"#{input}\" is not the correct length\nThe input needs to be two characters long"
        return input_square()
    end
    position = square_to_coordinets(input)
    if position == nil
        puts "Invalid input: #{input} is not a square on the board"
        return input_square()
    end
    return position
end

# Beskrivning: Returnerar text för hur många poäng en spelare har. Lägger till ett "+" om poängen är större än eller lika med 0
# Argument 1: Integer - poäng
# Return: String - poäng som sträng
# Exempel:
#       player_points_text(0) => "+0"
#       player_points_text(6) => "+6"
#       player_points_text(-3) => "-3"
# Datum 5/5/2024
# Namn: Noah Westerberg
def player_points_text(points)
    if points >= 0
        return "+#{points}"
    end
    return points.to_s
end

# Beskrivning: Skriver ut spelbrädan och spelarnas information
# Argument 1: Array - spelbrädan
# Argument 2: Bolean - om brädan ska vara omvänd eller inte
# Argument 3: Array - vilka rutor som ska vara markerade 
# Argument 4: Array - spelarna
# Argument 5: Integer - hur många blanksteg som ska göras innan spelet ritas ut
# Datum: 5/5/2024
# Namn: Noah Westerberg
def display_game(board, fliped, highlighted_squares, players, blank_spaces)
    top_text = ""
    bottom_text = ""
    if fliped
        top_text = "#{players[0].name} (#{player_points_text(players[0].points(board) - players[1].points(board))}) #{players[0].color.upcase}"
        bottom_text = "#{players[1].name} (#{player_points_text(players[1].points(board) - players[0].points(board))}) #{players[1].color.upcase}"
    else
        top_text = "#{players[1].name} (#{player_points_text(players[1].points(board) - players[0].points(board))}) #{players[1].color.upcase}"
        bottom_text = "#{players[0].name} (#{player_points_text(players[0].points(board) - players[1].points(board))}) #{players[0].color.upcase}"
    end
    
    print "\n" * blank_spaces
    puts top_text
    draw_board(board, fliped, highlighted_squares)
    puts bottom_text
end

# Beskrivning: Promoverar en bonde
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - bondens position
# Datum: 5/5/2024
# Namn: Noah Westerberg
def promote_pawn(board, position)
    puts "Your pawn at #{coordinets_to_square(position)} can promote!\nSelect which piece you want your pawn to turn into"
    promotion_piece = nil
    while promotion_piece == nil
        puts "Options: Queen, Knight, Rook, Bishop"
        input = gets.chomp
        if input.downcase == "queen"
            board[position.y][position.x] = Queen.new(position, board[position.y][position.x].color)
            break
        elsif input.downcase == "knight"
            board[position.y][position.x] = Knight.new(position, board[position.y][position.x].color)
            break
        elsif input.downcase == "rook"
            board[position.y][position.x] = Rook.new(position, board[position.y][position.x].color)
            break
        elsif input.downcase == "bishop"
            board[position.y][position.x] = Bishop.new(position, board[position.y][position.x].color)
            break
        end
        puts "Invalid Option!\n#{input} is an invalid option\nPlease Enter one of the following options"
    end
end

# Beskrivning: Game-loop
# Return: String - Vinnaren
# Argument 1: Array - Varje move läggs in här
# Exempel:
#       game() => players[0].name
#       game() => players[1].name
#       game() => "draw"
#       game() => "stalemate"
# Datum 7/5/2024
# Namn: Noah Westerberg
def game(replay)
    players = initialize_players()
    board = initialize_board()

    # Låt spelarna mata in namn
    for player in players
        name = player.name
        enterd_name = "no"
        while enterd_name.downcase == "no"
            puts "Player #{player.color.upcase}, what is your name?"
            input_name = gets.chomp
            if input_name != ""
                name = input_name
            end
            puts "Are you sure your name is \"#{name}\"?\nType \"no\" to re-enter your name"
            enterd_name = gets.chomp
        end
        player.name = name
    end
    
    winner = ""
    turn = 0
    is_fliped = false

    puts "Game Start!\n#{players[0].name} vs #{players[1].name}\nEnter \"draw\" at any time to end the game in a draw"
    continue_playing = true
    while continue_playing
        replay.append(Marshal.load(Marshal.dump(board)))
        # bestäm vems tur det är
        current_player = 0
        if turn % 2 == 0
            current_player = 0
        else
            current_player = 1
        end

        # undersök om spelet ska fortsätta
        avalible_positions = []
        for row in board
            for square in row
                if square.class == Empty 
                    next
                elsif square.class == En_passant_square
                    square.increment_round(board)
                else
                    if square.color == players[current_player].color
                        avalible_positions.concat(square.find_moves(board))
                    end
                end
            end
        end
        if avalible_positions.length == 0
            if is_king_attacked(board, players[current_player].color)
                winner = players[1 - current_player].name
            else
                winner = "stalemate"
            end
            display_game(board, !is_fliped, [], players, 100)
            continue_playing = false
            break
        end

        has_moved = false
        while !has_moved
            # bestäm vilken pjäs som ska flyttas
            selected_square = Empty.new
            avalible_positions = []
            while avalible_positions.length == 0
                display_game(board, is_fliped, [], players, 100)
                if selected_square.class != Empty && selected_square.class != En_passant_square
                    puts "The piece you selected has no avalible moves. Select another piece"
                else
                    puts "#{players[current_player].color.upcase} to move"
                    puts "Enter the square you want to select"
                end
                selected_square = Empty.new
                while selected_square.color != players[current_player].color
                    if selected_square.class != Empty && selected_square.class != En_passant_square
                        puts "The piece you selected is #{selected_square.color.upcase}\nSelect a piece that has your color, #{players[current_player].color.upcase}"
                    end
                    square_coordinets = input_square()
                    if square_coordinets == nil
                        next
                    elsif square_coordinets == "draw"
                        winner = "draw"
                        continue_playing = false
                        break
                    end
                    selected_square = board[square_coordinets.y][square_coordinets.x]
                    if selected_square.class == Empty || selected_square.class == En_passant_square
                        puts "The square you selected is Empty. Select another square"
                    end
                end
                if continue_playing == false
                    break
                end
                avalible_positions = selected_square.find_moves(board)
            end
            if continue_playing == false
                break
            end
            
            # bestäm vart pjösen ska flytta till
            new_move = false
            move_coordinets = nil
            while !avalible_positions.include?(move_coordinets)
                display_game(board, is_fliped, avalible_positions, players, 100)
                puts "Select the square you want your piece to move to\nPress ENTER to select another piece to move"
                if move_coordinets != nil
                    puts "\"#{coordinets_to_square(move_coordinets)}\" is not an avalible position"
                end
                move_coordinets = input_square()
                if move_coordinets == nil
                    puts "Move canceled"
                    new_move = true
                    break
                elsif move_coordinets == "draw"
                    winner = "draw"
                    continue_playing = false
                    break
                end
            end
            if new_move == true 
                next
            elsif continue_playing == false
                break
            end

            board[square_coordinets.y][square_coordinets.x].move(move_coordinets, board)
            has_moved = true

            # pawn promotion
            if move_coordinets.y == 0 || move_coordinets.y == 7
                if board[move_coordinets.y][move_coordinets.x].class == Pawn
                    promote_pawn(board, move_coordinets)
                end
            end
        end
        if continue_playing == false
            break
        end

        turn += 1
        is_fliped = !is_fliped
    end

    return winner
end

game_replay = []

# Game:
puts "Welcome to chess"
winner = game(game_replay)
if winner == "draw"
    puts "The game ended in a draw\nBetter luck next time"
elsif winner == "stalemate"
    puts "The game ended in stalemate\nMake sure your opponent will have avalible moves after your next move before you make your move"
else
    puts "The winner of the game is #{winner}!"
end

puts "Do you want to show a replay of the game\nEnter \"yes\" to confirm"
input = "input"
while input != ""
    input = gets.chomp
    if input.downcase == "yes"
        is_fliped = false
        for board in game_replay
            display_game(board, is_fliped, [], initialize_players(), 1)
            is_fliped = !is_fliped
        end
        input = ""
    end
end