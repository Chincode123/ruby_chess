Vector2 = Struct.new(:x, :y) do
    def +(vector)
        return Vector2.new(x + vector.x, y + vector.y)
    end
    def -(vector)
        return Vector2.new(x - vector.x, y - vector.y)
    end
    def *(num)
        return Vector2.new(x * num, y * num)
    end
    def /(num)
        return Vector2.new(x / num, y / num)
    end
end

# Beskrivning: Avrundar till 1, -1 eller 0
# Argument 1: Number/Int/float
# Return: Int. 1 om värdet är större än sqrt(2) / 2, -1 om värdet är minder än -sqrt(2) / 2 eller annars 0
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

# Beskrivning: Undersöker om en ruta finns på brädan och är en annan färg från pjäsen som använder funktionen och lägger till den i en input array
# Argument 1: Array, spelbrädan
# Argument 2: Vector2, positionen av rutan som ska kollas
# Argument 3: String: användar pjäsens färg
# Argument 4: Array: output array
# Return: Inget
# Exempel:
# Datum: 30/4/2024
# Namn: Noah Westerberg
def check_square(board, square_position, color, out)
    if square_position.x < board.length && square_position.y < board.length && square_position.x >= 0 && square_position.y >= 0
        check_square = board[square_position.y][square_position.x]
        check_square.set_targeted(color)
        if check_square.class == Empty
            out.append(square_position)
        elsif check_square.color != color
            out.append(square_position)
        end
    end
end

# Beskrivning: Lägger till rutor som finns i samma rad från en startposition och returnerar det.
# Argument 1: Array, spelbrädan
# Argument 2: Vector2, användarpjäsens position
# Argument 3: Vector2, hur marökern som sätter in rutorna justeras
# Argument 4: String: användar pjäsens färg
# Argument 5: Array: output-array
# Return: Inget
# Exempel:
#       Argument3/cursor_shift = (0, 0) => oändlig loop
# Datum: 4/5/2024
# Namn: Noah Westerberg
def check_squares_in_line(board, position, cursor_shift, color, out)
    p position
    
    x = position.x + cursor_shift.x
    y = position.y + cursor_shift.y
    while x < board.length && y < board.length && x >= 0 && y >= 0
        p "loop x:#{x} y:#{y}"

        check_square = board[y][x]
        p check_square
        check_square.set_targeted(color)
        if (check_square.class != Empty)
            if (check_square.color == color)
                break
            end

            out.append(Vector2.new(x, y))
            break
        end
        
        out.append(Vector2.new(x, y))
        x += cursor_shift.x
        y += cursor_shift.y
    end
end

class Piece
    # Beskrivning: Returnerar pjäsens icon
    # Return: String: pjäsens icon
    # Exempel:
    #       Pawn.icon => "P"
    #       Knigth.icon => "Kn"
    #       Piece.icon => error
    # Datum: 22/4/2024
    # Namn: Noah Westerberg
    def icon
        return @icon
    end

    # Beskrivning: Returnerar pjäsens färg/vilken spelare den tillhör
    # Return: String: pjäsens färg, antingen "white" eller "black"
    # Exempel:
    #       Piece.color => "white"
    #       Piece.color => "black"
    # Datum: 22/4/2024
    # Namn: Noah Westerberg
    def color
        return @color
    end

    # Beskrivning: Returnerar pjäsens position/cordinater
    # Return: Vector2: pjäsens position
    # Exempel:
    #       Piece.position => #<struct Vector2 x=0, y=0>
    #       Piece.position => #<struct Vector2 x=3, y=3>
    #       Piece.position => #<struct Vector2 x=7, y=5>
    #       Piece.position => #<struct Vector2 x=nil, y=nil>
    # Datum: 22/4/2024
    # Namn: Noah Westerberg
    def position
        return @position
    end

    # Beskrivning:
    # Argument 1:
    # Return:
    # Exempel:
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def is_targeted(color)
        if color == "white"
            return @targeted_by_black
        else
            return @targeted_by_white
        end
    end

    # Beskrivning:
    # Argument 1:
    # Return: Inget
    # Exempel:
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def set_targeted(color)
        if color == "white"
            @targeted_by_white = true
        else
            @targeted_by_black = true
        end
    end

    # Beskrivning:
    # Argument 1:
    # Return:
    # Exempel:
    # Datum: 24/4/2024
    # Namn: Noah Westerberg
    def remove_target(color)
        if color == "white"
            @targeted_by_white = false
        else
            @targeted_by_black = false
        end
    end

    # Beskrivning: Muterar pjäsens position. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). Om det är viktigt för pjäsen så sparas det att den har flytat på sig
    # Argument 1: Vector2: Positionen som pjäsen ska flyta sig till.
    # Argument 2: 2D-Array: Spelbrädan
    # Return: void
    # Exempel:
    # Datum: 4/5/2024
    # Namn: Noah Westerberg
    def move(position, board)
        board[@position.y][@position.x] = Empty.new

        if (self.class == Pawn || self.class == King || self.class == Rook)
            @has_moved = true
        end
            
        @position = position
        serialized_piece = Marshal.dump(self)
        board[position.y][position.x] = Marshal.load(serialized_piece)
    end
    
end

class Empty < Piece
    def initialize
        @icon = "#"
        @targeted_by_white = false
        @targeted_by_black = false
    end
end

class Pawn < Piece
    def initialize(position, color)
        @icon = "P"
        @color = color
        @position = position
        @has_moved = false
        @targeted_by_white = false
        @targeted_by_black = false

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
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2[]: tillgängliga positioner
    # Exempel:
    # Datum: 4/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        check_position = Vector2.new(@position.x, @position.y + @direction)
        if check_position.y < board.length && check_position.y >= 0
            check_square = board[check_position.y][check_position.x]
            if check_square.class == Empty
                positions.append(check_position)
            end
        end

        check_position = Vector2.new(@position.x - 1, @position.y + @direction)
        if check_position.x >= 0
            check_square = board[check_position.y][check_position.x]
            check_square.set_targeted(@color)
            if check_square.class != Empty
                if check_square.color != @color
                    positions.append(check_position)
                end
            end
        end

        check_position = Vector2.new(@position.x + 1, @position.y + @direction)
        if check_position.x < board.length
            check_square = board[check_position.y][check_position.x]
            check_square.set_targeted(@color)
            if check_square.class != Empty
                if check_square.color != @color
                    positions.append(check_position)
                end
            end
        end
        
        if @has_moved
            return positions
        end

        check_position = Vector2.new(@position.x, @position.y + (@direction * 2))
        check_square = board[check_position.y][check_position.x]
        if check_square.class == Empty
            positions.append(check_position)
        end

        return positions
    end
end

class King < Piece
    def initialize(position, color)
        @icon = "K"
        @color = color
        @position = position
        @has_moved = false
        @targeted_by_white = false
        @targeted_by_black = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2[]: tillgängliga positioner
    # Exempel:
    # Datum: 4/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        angle = 0
        while angle < 2 * Math::PI
            new_position = Vector2.new(@position.x + round_angle(Math.cos(angle)), @position.y + round_angle(Math.sin(angle)))
            angle += Math::PI / 4

            check_square(board, new_position, @color, positions)
        end

        for position in positions
            if (board[position.y][position.x].is_targeted(@color))
                positions.delete(position)
            end
        end

        return positions
    end
end

class Queen < Piece
    def initialize(position, color)
        @icon = "Q"
        @color = color
        @position = position
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2[]: tillgängliga positioner
    # Exempel:
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
        return positions
    end
end

class Knight < Piece
    def initialize(position, color)
        @icon = "Kn"
        @color = color
        @position = position
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2 Array: tillgängliga positioner
    # Exempel:
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

        return positions
    end
end

class Rook < Piece
    def initialize(position, color)
        @icon = "R"
        @color = color
        @position = position
        @has_moved = false
        @targeted_by_white = false
        @targeted_by_black = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2 Array: tillgängliga positioner
    # Exempel:
    # Datum: 2/5/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []

        check_squares_in_line(board, @position, Vector2.new(1, 0), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(-1, 0), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(0, 1), @color, positions)
        check_squares_in_line(board, @position, Vector2.new(0, -1), @color, positions) 

        return positions
    end
end

class Bishop < Piece
    def initialize(position, color)
        @icon = "B"
        @color = color
        @position = position
        @targeted_by_white = false
        @targeted_by_black = false
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Vector2 Array: tillgängliga positioner
    # Exempel:
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

        return positions
    end
end