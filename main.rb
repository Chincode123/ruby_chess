require_relative "pieces.rb"
require_relative "draw.rb"

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

board[0][0] = Rook.new(Vector2.new(0, 0), "w")
board[0][7] = Rook.new(Vector2.new(7, 0), "w")
board[0][1] = Knight.new(Vector2.new(1, 0), "w")
board[0][6] = Knight.new(Vector2.new(6, 0), "w")
board[0][2] = Bishop.new(Vector2.new(2, 0), "w")
board[0][5] = Bishop.new(Vector2.new(5, 0), "w")
board[0][4] = King.new(Vector2.new(4, 0), "w")
board[0][3] = Queen.new(Vector2.new(3, 0), "w")
board[1][0] = Pawn.new(Vector2.new(0, 1), "w")
board[1][1] = Pawn.new(Vector2.new(1, 1), "w")
board[1][2] = Pawn.new(Vector2.new(2, 1), "w")
board[1][3] = Pawn.new(Vector2.new(3, 1), "w")
board[1][4] = Pawn.new(Vector2.new(4, 1), "w")
board[1][5] = Pawn.new(Vector2.new(5, 1), "w")
board[1][6] = Pawn.new(Vector2.new(6, 1), "w")
board[1][7] = Pawn.new(Vector2.new(7, 1), "w")

board[7][0] = Rook.new(Vector2.new(0, 7), "b")
board[7][7] = Rook.new(Vector2.new(7, 7), "b")
board[7][1] = Knight.new(Vector2.new(1, 7), "b")
board[7][6] = Knight.new(Vector2.new(6, 7), "b")
board[7][2] = Bishop.new(Vector2.new(2, 7), "b")
board[7][5] = Bishop.new(Vector2.new(5, 7), "b")
board[7][4] = King.new(Vector2.new(4, 7), "b")
board[7][3] = Queen.new(Vector2.new(3, 7), "b")
board[6][0] = Pawn.new(Vector2.new(0, 6), "b")
board[6][1] = Pawn.new(Vector2.new(1, 6), "b")
board[6][2] = Pawn.new(Vector2.new(2, 6), "b")
board[6][3] = Pawn.new(Vector2.new(3, 6), "b")
board[6][4] = Pawn.new(Vector2.new(4, 6), "b")
board[6][5] = Pawn.new(Vector2.new(5, 6), "b")
board[6][6] = Pawn.new(Vector2.new(6, 6), "b")
board[6][7] = Pawn.new(Vector2.new(7, 6), "b")

# draw_board(board, false)

# Beskrivning: Omvandlar en rutbetäckning till cordinater
# Argument 1: String: rutbetöckning
# Return: Vector2: cordinater. nil: error
# Exempel:
#       square_to_cordinets("a1") => (0, 0)
#       square_to_cordinets("h8") => (7, 7) 
#       square_to_cordinets("e4") => (4, 4) 
#       square_to_cordinets("E4") => (4, 4) 
#       square_to_cordinets("N2") => nil
#       square_to_cordinets("cb") => nil
#       square_to_cordinets("d0") => nil
# Datum: 2/5/2024
# Namn: Noah Westerberg
def square_to_cordinets(square)
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

input = gets.chomp
while input != "quit"
    if (input.length < 2)
        input = gets.chomp
        next
    end
    square = input[0].downcase + input[1]
    p square_to_cordinets(square)
    input = gets.chomp
end