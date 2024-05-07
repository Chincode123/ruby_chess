Vector2 = Struct.new(:x, :y) do
    # Beskrivning: Adderar vectorer
    # Argument 1: Vector2 - vectorn som ska adderas på
    # Return: Vector2 - den adderade vectorn
    # Exempel:
    #          (1, 2) + (3, 0) => (4, 2)
    #          (5, 4) + (2, 3) => (7, 7)
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def +(vector)
        return Vector2.new(x + vector.x, y + vector.y)
    end

    # Beskrivning: Subtraherar vectorer
    # Argument 1: Vector2 - vectorn som ska adderas på
    # Return: Vector2 - den subtraherade vectorn
    # Exempel:
    #          (1, 2) - (3, 0) => (-2, -2)
    #          (5, 4) - (2, 3) => (3, 1)
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def -(vector)
        return Vector2.new(x - vector.x, y - vector.y)
    end

    # Beskrivning: Multiplicerar en vector
    # Argument 1: int/float - talet som vectorn ska multipliceras med
    # Return: Vector2 - den multiplicerade vectorn
    # Exempel:
    #          (1, 2) * 3 => (3, 6)
    #          (5, 4) * 2 => (10, 8)
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def *(num)
        return Vector2.new(x * num, y * num)
    end

    # Beskrivning: Dividerar en vector
    # Argument 1: int/float - talet som vectorn ska divideras med
    # Return: Vector2 - den dividerade vectorn
    # Exempel:
    #          (1, 2) / 3 => (1/3, 2/3)
    #          (5, 4) / 2 => (5/2, 2)
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def /(num)
        return Vector2.new(x / num, y / num)
    end
end

# Beskrivning: Avrundar hypotenusan av en vinkel till 1, -1 eller 0
# Argument 1: int/float
# Return: Int - 1 om värdet är större än sqrt(2) / 2, -1 om värdet är minder än -sqrt(2) / 2 eller annars 0
# Exempel:
#           round_angle(0) => 0
#           round_angle(1) => 1
#           round_angle(-1) => -1
#           round_angle(0.70) => 1
#           round_angle(0.69) => 0
#           round_angle(0) => 0
# Datum: 23/4/2024
# Namn: Noah Westerberg
def round_angle(num)
    # lite marginal för att undvika gränsfall
    if num < -Math.sqrt(2) + 1.1
        return -1
    elsif num > Math.sqrt(2) - 1.1
        return 1
    else
        return 0
    end
end

# Beskrivning: Undersöker om en ruta finns på brädan och är en annan färg från pjäsen som använder funktionen och lägger till den i en output array
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - positionen av rutan som ska kollas
# Argument 3: String - användar pjäsens färg
# Argument 4: Array - output array
# Return: 
#       Piece - Pjäsen som ska undersökas
#       nil - Det finns ingen ruta vid positionen
# Datum: 6/5/2024
# Namn: Noah Westerberg
def check_square(board, square_position, color, out)
    if square_position.x < board.length && square_position.y < board.length && square_position.x >= 0 && square_position.y >= 0
        check_square = board[square_position.y][square_position.x]
        if check_square.class != Empty && check_square.class != En_passant_square
            if check_square.color != color
                out.append(square_position)
            end
            return check_square
        end
        out.append(square_position)
    end
    return nil
end

# Beskrivning: Undersöker om en ruta finns på brädan och är en annan färg från pjäsen som använder funktionen och lägger till den i en output array. Söker även efter en passant
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - positionen av rutan som ska kollas
# Argument 3: String - användar pjäsens färg
# Argument 4: Array - output array
# Return: 
#       Piece - Pjäsen som ska undersökas
#       nil - Det finns ingen ruta vid positionen
# Exempel:
# Datum: 6/5/2024
# Namn: Noah Westerberg
def check_square_en_passant(board, square_position, color, out)
    if square_position.x < board.length && square_position.y < board.length && square_position.x >= 0 && square_position.y >= 0
        check_square = board[square_position.y][square_position.x]
        if check_square.class != Empty
            if check_square.color != color
                out.append(square_position)
            end
            return check_square
        end
        out.append(square_position)
    end
    return nil
end

# Beskrivning: Lägger till rutor som finns i samma rad från en startposition i en riktning i en output array och returnerar den första rutan som inte är tom 
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - användarpjäsens position
# Argument 3: Vector2 - hur marökern justeras
# Argument 4: String - användar pjäsens färg
# Argument 5: Array: output-array
# Return: 
#       Piece - Den första pjäsen på raden
#       nil - Det är tomt hela vägen till kanten av brädan
# Exempel:
#       Argument3/cursor_shift = (0, 0) => oändlig loop
# Datum: 4/5/2024
# Namn: Noah Westerberg
def check_squares_in_line(board, position, cursor_shift, color, out)
    x = position.x + cursor_shift.x
    y = position.y + cursor_shift.y
    while x < board.length && y < board.length && x >= 0 && y >= 0
        check_square = board[y][x]
        if check_square.class != Empty && check_square.class != En_passant_square
            if check_square.color != color
                out.append(Vector2.new(x, y))
            end
            return board[y][x]
        end
        
        out.append(Vector2.new(x, y))
        x += cursor_shift.x
        y += cursor_shift.y
    end
    return nil
end

# Beskrivning: tar fram närligande rutor runt en ruta
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - rutans position
# Return:
#   Array - positioner av närliggande rutor
#   nil - det finns inga närliggande rutor
# Exempel:
# Datum: 6/5/2024
# Namn: Noah Westerberg
def find_adjacent_squares(board, position)
    positions = []
    angle = 0
    while angle < 2 * Math::PI
        adjacent_position = Vector2.new(position.x + round_angle(Math.cos(angle)), position.y + round_angle(Math.sin(angle)))
        check_square(board, adjacent_position, "", positions)
        angle += Math::PI / 4
    end
    if position.length > 0
        return positions
    else
        return nil
    end
end

# Beskrivning: Kopierar spelbrädan, flyttar en pjäs på den och returnerar kopian
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - positionen av pjäsen som ska flyttas
# Argument 3: Vector2 - positionen som pjäsen ska flyttas till
# Return Array - kopian av brädan
# Datum 6/5/2024
# Namn: Noah Westerberg
def move_on_board(board, piece_position, move_position)
    new_board = Marshal.load(Marshal.dump(board))
    new_board[piece_position.y][piece_position.x].move(move_position, new_board)
    return new_board
end

# Beskrivning: Undersöker om en kung är attackerad
# Argument 1: Array - spelbrädan
# Argument 2: String - färgen på kungen som ska undersökas
# Return:
#       Bolean - true om kungen är attackerad, annars false
#       nil - det finns ingen kung av den inmatade färgen på brädan
# Datum: 6/5/2024
# Namn: Noah Westerberg
def is_king_attacked(board, color)
    for row in board
        for square in row
            if square.class == King
                if square.color == color
                    return square.is_targeted(board, square.position, color)
                end
            end
        end
    end
    return nil
end

# Beskrivning: Undersöker om en kung är attackerad efter en move
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - positionen av pjäsen som ska flytas
# Argument 3: Vector2 - positionen pjäsen ska flyttas till
# Argument 4: String - färgen av kungen som ska kollas
# Return:
#       Bolean - true om kungen är attackerad, annars false
# Datum: 7/5/2024
# Namn: Noah Westerberg
def check_move(board, piece_position, move_position, color)
    new_board = move_on_board(board, piece_position, move_position)
    return is_king_attacked(new_board, color)
end

# Beskrivning: Validerar moves. Tar bort en tilgänlig position om kungen attackeras
# Argument 1: Array - spelbrädan
# Argument 2: Vector2 - positionen av pjäsen som ska flytas
# Argument 3: Array - positionerna pjäsen ska flyttas till
# Argument 4: String - färgen av kungen som ska kollas
# Return: nil
# Datum: 7/5/2024
# Namn: Noah Westerberg
def validate_moves(board, piece_position, move_positions, color)
    i = 0
    while i < move_positions.length
        if check_move(board, piece_position, move_positions[i], color)
            move_positions.delete_at(i)
        else
            i += 1
        end
    end
end

class Piece
    attr_reader :color, :position, :icon

    # Beskrivning: Utforskar om en ruta attackeras av en motståndarpjäs
    # Argument 1: Array - spelbärdan
    # Argument 2: Vector2 - rutan som ska undersökas' position
    # Argument 3: String - användar pjäsens färg
    # Return: Bolean - true om rutan attackeras. false om den inte attackeras
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def is_targeted(board, position, color)
        target_color = ""
        if color == "white"
            target_color = "black"
        else
            target_color = "white"
        end
        is_targeted = false

        # Queen, Rook, Bishop
        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                if (x_dir == 0 && y_dir == 0)
                    y_dir += 1
                    next
                end
                check_square = check_squares_in_line(board, position, Vector2.new(x_dir, y_dir), "", [])
                if check_square != nil  
                    if x_dir == 0 || y_dir == 0
                        if check_square.class == Rook || check_square.class == Queen
                            if check_square.color == target_color
                                is_targeted = true
                            end
                        end
                    elsif check_square.class == Bishop || check_square.class == Queen
                        if check_square.color == target_color
                            is_targeted = true
                        end
                    end
                end
                y_dir += 1
            end
            x_dir += 1
        end

        # Knight
        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                check_square = check_square(board,  position + Vector2.new(2 * x_dir, 1 * y_dir), "", [])
                if check_square != nil
                    if check_square.class == Knight
                        if check_square.color == target_color
                            is_targeted = true
                        end
                    end
                end
                check_square = check_square(board, position + Vector2.new(1 * x_dir, 2 * y_dir), "", [])
                if check_square != nil
                    if check_square.class == Knight
                        if check_square.color == target_color
                            is_targeted = true
                        end
                    end
                end
                y_dir += 2
            end
            x_dir += 2
        end

        # Pawn
        pawn_direction = 0
        if target_color == "white"
            pawn_direction = -1
        else
            pawn_direction = 1
        end
        x_dir = -1
        while x_dir <= 1
            check_position = Vector2.new(position.x + x_dir, position.y + pawn_direction)
            check_square = check_square(board, check_position, "", [])
            if check_square != nil
                if check_square.class == Pawn
                    if check_square.color == target_color
                        is_targeted = true
                    end
                end
            end
            x_dir += 2
        end

        # King
        positions = find_adjacent_squares(board, position)
        if positions != nil
            i = 0
            while i < positions.length
                check_square = check_square(board, positions[i], "", [])
                if check_square.class == King
                    if check_square.color == target_color
                        is_targeted = true
                    end
                end
                i += 1
            end
        end

        return is_targeted
    end

    # Beskrivning: Flyttar på pjäsen. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace)
    # Argument 1: Vector2 - Positionen som pjäsen ska flyta sig till.
    # Argument 2: Array - Spelbrädan
    # Return: nil
    # Datum: 4/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        board[@position.y][@position.x] = Empty.new
        @position = position
        board[position.y][position.x] = Marshal.load(Marshal.dump(self))
    end
end

class Empty < Piece
    def initialize
        @icon = "#"
    end
end

class En_passant_square < Piece
    def initialize(position, color)
        @icon = "#"
        @position = position
        @color = color
        @round = 0
    end

    # Beskrivning: ökar hur många rundor som en passant rutan har funnits. Den tas bort efter att den har varit aktiv i en runda
    # Argument 1: Array - spelbrädan
    # Datum 5/5/2024
    # Namn: Noah Westerberg
    def increment_round(board)
        @round += 1
        if @round >= 2
            board[position.y][position.x] = Empty.new
        end
    end
end

class Pawn < Piece
    def initialize(position, color)
        @icon = "P"
        @color = color
        @position = position
        @has_moved = false

        if color == "white"
            @direction = 1
        else
            @direction = -1
        end
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: Array - spelbrädan
    # Return: Array - tillgängliga positioner
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        check_position = Vector2.new(@position.x, @position.y + @direction)
        if check_position.y < board.length && check_position.y >= 0
            check_square = board[check_position.y][check_position.x]
            if check_square.class == Empty
                positions.append(check_position)
                if @has_moved == false
                    check_position = Vector2.new(@position.x, @position.y + (@direction * 2))
                    check_square = board[check_position.y][check_position.x]
                    if check_square.class == Empty
                        positions.append(check_position)
                    end
                end
            end
        end

        x = -1
        while x <= 1
            check_position = Vector2.new(@position.x + x, @position.y + @direction)
            check_square = check_square_en_passant(board, check_position, @color, [])
            if check_square != nil
                if check_square.color != @color
                    positions.append(check_position)
                end
            end
            x += 2
        end

        validate_moves(board, @position, positions, @color)

        return positions
    end

    # Beskrivning: Flyttar på pjäsen. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). kollar om en en passant ruta borde läggas till.
    # Argument 1: Vector2 - Positionen som pjäsen ska flyta sig till.
    # Argument 2: Array - Spelbrädan
    # Return: nil
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        if (position.y - @position.y).abs > 1
            en_passant_position = Vector2.new(@position.x, @position.y + ((position.y - @position.y) / 2))
            board[en_passant_position.y][en_passant_position.x] = En_passant_square.new(en_passant_position, @color)
        end
        if board[position.y][position.x].class == En_passant_square
            pawn_position = Vector2.new(@position.x + (position.x - @position.x), position.y + ((@position.y - position.y)))
            board[pawn_position.y][pawn_position.x] = Empty.new
        end

        board[@position.y][@position.x] = Empty.new
        @position = position
        @has_moved = true
        board[position.y][position.x] = Marshal.load(Marshal.dump(self))

    end
end

class King < Piece
    def initialize(position, color)
        @icon = "K"
        @color = color
        @position = position
        @has_moved = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: Array - spelbrädan
    # Return: Array - tillgängliga positioner
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = find_adjacent_squares(board, @position)
        if positions != nil
            i = 0
            while i < positions.length
                if  board[positions[i].y][positions[i].x].color == @color
                    positions.delete_at(i)
                    next
                end
                i += 1
            end
            validate_moves(board, @position, positions, @color)
        end

        if @has_moved == false
            i = -1
            while i <= 1
                rook_square = check_squares_in_line(board, @position, Vector2.new(i, 0), @color, [])
                if rook_square.class == Rook
                    if rook_square.has_moved == false
                        targeted = false
                        j = 0
                        while j <= 2
                            check_position = Vector2.new(@position.x + (j * i), @position.y)
                            if board[check_position.y][check_position.x].is_targeted(board, check_position, @color)
                                targeted = true
                            end
                            j += 1
                        end
                        if targeted == false
                            positions.append(Vector2.new(@position.x + (2 * i), @position.y))
                        end
                    end
                end
                i += 2
            end
        end

        return positions
    end

    # Beskrivning: Flyttar på pjäsen. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). Kollar om det går att göra rockad
    # Argument 1: Vector2 - Positionen som pjäsen ska flyta sig till.
    # Argument 2: Array - Spelbrädan
    # Return: nil
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        if (@position.x - position.x).abs > 1
            rook_position = Vector2.new
            if (@position.x - position.x) < 0
                rook_position = Vector2.new(7, @position.y)
                rook = board[rook_position.y][rook_position.x]
                rook.move(Vector2.new(position.x - 1, position.y), board)
            else
                rook_position = Vector2.new(0, @position.y)
                rook = board[rook_position.y][rook_position.x]
                rook.move(Vector2.new(position.x + 1, position.y), board)
            end
        end
        
        board[@position.y][@position.x] = Empty.new
        @has_moved = true    
        @position = position
        board[position.y][position.x] = Marshal.load(Marshal.dump(self))

    end
end

class Queen < Piece
    def initialize(position, color)
        @icon = "Q"
        @color = color
        @position = position
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: Array - spelbrädan
    # Return: Array - tillgängliga positioner
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        
        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                if (x_dir == 0 && y_dir == 0)
                    y_dir += 1
                    next
                end
                check_squares_in_line(board, @position, Vector2.new(x_dir, y_dir), @color, positions)
                y_dir += 1
            end
            x_dir += 1
        end

        validate_moves(board, @position, positions, @color)

        return positions
    end
end

class Knight < Piece
    def initialize(position, color)
        @icon = "Kn"
        @color = color
        @position = position
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: Array - spelbrädan
    # Return: Array - tillgängliga positioner
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                check_square(board, @position + Vector2.new(2 * x_dir, 1 * y_dir), @color, positions)
                check_square(board, @position + Vector2.new(1 * x_dir, 2 * y_dir), @color, positions)
                y_dir += 2
            end
            x_dir += 2
        end

        validate_moves(board, @position, positions, @color)

        return positions
    end
end

class Rook < Piece
    def initialize(position, color)
        @icon = "R"
        @color = color
        @position = position
        @has_moved = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: Array - spelbrädan
    # Return: Array - tillgängliga positioner
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        check_squares_in_line(board, @position, Vector2.new(1, 0), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(-1, 0), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(0, 1), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(0, -1), @color, positions) 

        validate_moves(board, @position, positions, @color)

        return positions
    end

    # Beskrivning: Flyttar på pjäsen. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace)
    # Argument 1: Vector2 - Positionen som pjäsen ska flyta sig till.
    # Argument 2: Array - Spelbrädan
    # Return: nil
    # Datum: 6/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        board[@position.y][@position.x] = Empty.new
        @has_moved = true
        @position = position
        board[position.y][position.x] = Marshal.load(Marshal.dump(self))
    end
end

class Bishop < Piece
    def initialize(position, color)
        @icon = "B"
        @color = color
        @position = position
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: Array - spelbrädan
    # Return: Array - tillgängliga positioner
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        x_dir = -1
        while x_dir <= 1
            y_dir = -1
            while y_dir <= 1
                check_squares_in_line(board, @position, Vector2.new(x_dir, y_dir), @color, positions)
                y_dir += 2
            end
            x_dir += 2
        end

        validate_moves(board, @position, positions, @color)

        return positions
    end
end