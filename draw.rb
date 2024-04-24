require "rainbow"
using Rainbow

def draw_board(board)
    print " |A|B|C|D|E|F|G|H\n"
    i = 0
    while i < 8
        print "#{8-i}|"
        j = 0
        while j < 8
            current_space = board[i][j].icon
            if board[i][j].class != Knight
                current_space += " "
            end
            
            if board[i][j].color == nil
                current_space = Rainbow(current_space).hide
            elsif board[i][j].color == "w"
                current_space = Rainbow(current_space).snow
            else
                current_space = Rainbow(current_space).black
            end

            if (j + i) % 2 == 0
                current_space = Rainbow(current_space).bg(:bisque)
            else
                current_space = Rainbow(current_space).bg(:black)
            end

            print current_space
            
            j += 1
        end
        print "\n"
        i += 1
    end
end