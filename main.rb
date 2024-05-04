require_relative "pieces.rb"
require_relative "draw.rb"

# Beskrivning: Returnerar hur många poäng en pjäs är värd
# Argument 1: Piece
# Return: Integer: poängvärdet av pjäsen
# Exempel:
#       piece_to_points(Pawn) => 1
#       piece_to_points(Knight) => 3
#       piece_to_points(Bishop) => 3
#       piece_to_points(Rook) => 5
#       piece_to_points(Queen) => 9
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
    # Argument 1: 2D-Array: Spelbrädan
    # Return: Integer
    # Exempel: 
    # Noah Westerberg
    # Datum 5/5/2024
    def points(board)
        points = 0
        for row in board
            for piece in row
                if piece.class != Empty
                    if piece.color == color
                        points += piece_to_points(piece)
                    end
                end
            end
        end
    end
end

player1 = Player.new("Player 1", "white")
player2 = Player.new("Player 2", "black")

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
board[7][4] = King.new(Vector2.new(4, 7), "black")
board[7][3] = Queen.new(Vector2.new(3, 7), "black")
board[6][0] = Pawn.new(Vector2.new(0, 6), "black")
board[6][1] = Pawn.new(Vector2.new(1, 6), "black")
board[6][2] = Pawn.new(Vector2.new(2, 6), "black")
board[6][3] = Pawn.new(Vector2.new(3, 6), "black")
board[6][4] = Pawn.new(Vector2.new(4, 6), "black")
board[6][5] = Pawn.new(Vector2.new(5, 6), "black")
board[6][6] = Pawn.new(Vector2.new(6, 6), "black")
board[6][7] = Pawn.new(Vector2.new(7, 6), "black")

# Beskrivning: Omvandlar en rutbetäckning till cordinater
# Argument 1: String: rutbetöckning. De första två karaktärerna ska vara rutbetäckningen 
# Return: Vector2: cordinater. nil: error
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

# Beskrivning:
# Return: Vector2: cordinaterna för rutan som är vald
# Exempel:
# Datum: 3/5/2024
# Namn: Noah Westerberg
def input_square()
    input = gets.chomp
    if (input.length < 2)
        return input_square()
    end
    position = square_to_coordinets(input)
    if (position == nil)
        return input_square()
    end
    return position
end

def game()
    turn = 0
    is_fliped = false

    while true
        current_player = Player.new
        if turn % 2 == 0
            current_player = player1
        else
            current_player = player2
        end

        p current_player
        p current_player.color

        for row in board
            for square in row
                if (square.class == Empty)
                    next
                end
                square.find_moves(board)
            end
        end

        draw_board(board, is_fliped, [])

        selected_square = Empty.new
        avalible_positions = []
        while avalible_positions.length == 0
            selected_square = Empty.new
            while selected_square.color != current_player.color
                square_coordinets = input_square()
                selected_square = board[square_coordinets.y][square_coordinets.x]
            end
            avalible_positions = selected_square.find_moves(board)
        end

        draw_board(board, is_fliped, avalible_positions)

        move_coordinets = Vector2.new
        while !avalible_positions.include?(move_coordinets)
            move_coordinets = input_square()
        end

        selected_square.move(move_coordinets, board)

        turn += 1
        is_fliped = !is_fliped
    end
end


game()