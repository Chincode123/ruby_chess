require "rainbow"
using Rainbow


def draw_board(board, fliped, highlighted_squares)
    if fliped
        print "  H|G|F|E|D|C|B|A\n"
        i = 0
        loop_end_value = board.length
    else
        print "  A|B|C|D|E|F|G|H\n"
        i = board.length - 1
        loop_end_value = -1
    end
    while i != loop_end_value
        print "#{i+1}|"
        j = 0
        if fliped
            j = board.length - 1
        end
        while j != 7 - loop_end_value
            current_square = board[i][j]
            square_text = current_square.icon
            if board[i][j].class != Knight
                square_text += " "
            end
            
            if board[i][j].color == nil
                square_text = Rainbow(square_text).hide
            elsif board[i][j].color == "w"
                square_text = Rainbow(square_text).bisque
            else
                square_text = Rainbow(square_text).black
            end

            if (j + i) % 2 == 0
                square_text = Rainbow(square_text).bg(:burlywood)
            else
                square_text = Rainbow(square_text).bg(:brown)
            end

            if (highlighted_squares.include?(Vector2.new(j, i)))
                square_text = Rainbow(square_text).bg(:blue).red
            end

            print square_text
            
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