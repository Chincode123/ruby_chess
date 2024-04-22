require "rainbow"
using Rainbow

def draw_board(board)
    i = 0
    while i < 8
        print "|"
        j = 0
        while j < 8
            if (j + i) % 2 == 0
                if board[i][j].color = nil
                    print board[i][j].icon.bg(:white)
                elsif board[i][j].color = "white"
                    print Rainbow(board[i][j].icon).white.bg(:white).bright
                else
                    print Rainbow(board[i][j].icon).black.bg(:white).bright
                end
            else
                if board[i][j].color = nil
                    print board[i][j].icon.bg(:black)
                elsif board[i][j].color = "white"
                    print Rainbow(board[i][j].icon).white.bg(:black).bright
                else
                    print Rainbow(board[i][j].icon).black.bg(:black).bright
                end
            end
            print "|"
            j += 1
        end
        print "|\n"
        i += 1
    end
end