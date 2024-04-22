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

board[0][0] = Rook.new(Cordinets.new(0, 0), "b")
board[0][7] = Rook.new(Cordinets.new(7, 0), "b")
board[0][1] = Knight.new(Cordinets.new(1, 0), "b")
board[0][6] = Knight.new(Cordinets.new(6, 0), "b")
board[0][2] = Bishop.new(Cordinets.new(2, 0), "b")
board[0][5] = Bishop.new(Cordinets.new(5, 0), "b")
board[0][3] = King.new(Cordinets.new(3, 0), "b")
board[0][4] = Queen.new(Cordinets.new(4, 0), "b")

board[7][0] = Rook.new(Cordinets.new(0, 7), "w")
board[7][7] = Rook.new(Cordinets.new(7, 7), "w")
board[7][1] = Knight.new(Cordinets.new(1, 7), "w")
board[7][6] = Knight.new(Cordinets.new(6, 7), "w")
board[7][2] = Bishop.new(Cordinets.new(2, 7), "w")
board[7][5] = Bishop.new(Cordinets.new(5, 7), "w")
board[7][3] = King.new(Cordinets.new(3, 7), "w")
board[7][4] = Queen.new(Cordinets.new(4, 7), "w")


draw_board(board)



