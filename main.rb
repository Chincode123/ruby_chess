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
    [Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new, Empty.new],
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

draw_board(board, false)