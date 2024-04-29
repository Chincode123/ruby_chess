require "rainbow"
using Rainbow

def draw_board(board, fliped)
    if fliped
        print "  H|G|F|E|D|C|B|A\n"
        i = 0
        loop_end_value = 8
    else
        print "  A|B|C|D|E|F|G|H\n"
        i = 7
        loop_end_value = -1
    end
    while i != loop_end_value
        print "#{i+1}|"
        j = 0
        if fliped
            j = 7
        end
        while j != 7 - loop_end_value
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
            
            if fliped
                j -= 1
            else
            j += 1
            end
        end
        print "|#{i+1}\n"
        if fliped
            i += 1
        else
            i -= 1
        end
    end
    if fliped
        print "  H|G|F|E|D|C|B|A\n"
    else
        print "  A|B|C|D|E|F|G|H\n"
    end
end