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
    if square_position.x < board[square_position.y].length && square_position.y < board.length && square_position.x >= 0 && square_position.y >= 0
        check_square = board[square_position.y][square_position.x]
        check_square.set_targeted(color)
        if check_square.class == Empty
            out.append(square_position)
            return
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
# Return: Array, rutor i en rad
# Exempel:
#       Argument3/cursor_shift = (0, 0) => oändlig loop
# Datum: 29/4/2024
# Namn: Noah Westerberg
def check_squares_in_line(board, position, cursor_shift, color)
    squares = []
    
    x = position.x
    y = position.y
    while x < board[y].length && y < board.length && x >= 0 && y >= 0
        check_square = board[y][x]
        check_square.set_targeted(color)
        if (check_square.class != Empty)
            if (check_square.color == color)
                break
            end
        end
        
        squares.append(check_square)
        x += cursor_shift.x
        y += cursor_shift.y
    end

    return squares
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
    # Return: String: pjäsens färg, antingen "w" eller "b"
    # Exempel:
    #       Piece.color => "w"
    #       Piece.color => "b"
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
        if color == "w"
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
        if color == "w"
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
        if color == "w"
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
    # Datum: 22/4/2024
    # Namn: Noah Westerberg
    def move(position, board)
        board[position.y][position.x] = self.copy
        board[@position.y][@position.y] = Empty.new

        @position = position
        if (@has_moved != nil)
            @has_moved = true
        end
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

        if color == "w"
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
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        check_square = board[@position.y + @direction][@position.x]
        if check_square.class == Empty
            positions.append(check_square.position)
        end
        check_square = board[@position.y + @direction][@position.x - 1]
        check_square.set_targeted(@color)
        if check_square.class != Empty
            if check_square.color != @color
                positions.append(check_square.position)
            end
        end
        check_square = board[@position.y + @direction][@position.x + 1]
        check_square.set_targeted(@color)
        if check_square.class != Empty
            if check_square.color != @color
                positions.append(check_square.position)
            end
        end
        if @has_moved
            return positions
        end
        check_square = board[@position.y + (@direction * 2)][@position.x]
        if check_square.class == Empty
            positions.append(check_square.position)
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
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        angle = 0
        while angle < 2 * Math::PI
            new_position = Vector2.new(@position.x + round_angle(Math.cos(angle)), @position.y + round_angle(Math.sin(angle)))
            angle += Math::PI / 4

            check_square = board[new_position.y][new_position.x]
            check_square.set_targeted(@color)
            if check_square.class == Empty
                positions.append(new_position)
            elsif check_square.color != @color
                positions.append(new_position)
            end
            # Ser kneppt ut att set_targeted används och så kollar man om rutan är attackerad precise efter, men is_targeted returnerar om den motsatta färgen attackerar
            if check_square.is_targeted(@color)
                positions.delete(new_position)
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
                positions.concat(check_squares_in_line(board, @position, Vector2.new(x_dir, y_dir), @color))
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
                check_square(board, @position + Vector2.new(3 * x_dir, 1 * y_dir), @color, positions)
                check_square(board, @position + Vector2.new(1 * x_dir, 3 * y_dir), @color, positions)
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

        positions.concat(check_squares_in_line(board, @position, Vector2.new(1, 0), @color)) 
        positions.concat(check_squares_in_line(board, @position, Vector2.new(-1, 0), @color)) 
        positions.concat(check_squares_in_line(board, @position, Vector2.new(0, 1), @color)) 
        positions.concat(check_squares_in_line(board, @position, Vector2.new(0, -1), @color)) 

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
                positions.concat(check_squares_in_line(board, @position, Vector2.new(x_dir, y_dir), @color))
                y_dir += 2
            end
            x_dir += 2
        end

        return positions
    end
end