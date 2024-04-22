require "rainbow"
using Rainbow

def draw_board(board)
    i = 0
    while i < 8
        j = 0
        while j < 8
            current_space = board[i][j].icon
            if board[i][j].class != Knight
                current_space += " "
            end

            if (j + i) % 2 == 0
                if board[i][j].color == nil
                    print Rainbow(current_space).bg(:aliceblue).hide
                elsif board[i][j].color == "w"
                    print Rainbow(current_space).bg(:aliceblue).white
                else
                    print Rainbow(current_space).bg(:aliceblue).brown.bright
                end
            else
                if board[i][j].color == nil
                    print Rainbow(current_space).bg(:black).hide
                elsif board[i][j].color == "w"
                    print Rainbow(current_space).bg(:black).white
                else
                    print Rainbow(current_space).bg(:black).brown.bright
                end
            end
            j += 1
        end
        print "\n"
        i += 1
    end
end