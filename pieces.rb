
Cordinets = Struct.new(:x, :y) do
    def +(cordinets)
        return Cordinets.new(x + cordinets.x, y + cordinets.y)
    end
    def -(cordinets)
        return Cordinets.new(x - cordinets.x, y - cordinets.y)
    end
    def *(num)
        return Cordinets.new(x * num, y * num)
    end
    def /(num)
        return Cordinets.new(x / num, y / num)
    end
end

# Beskrivning: Avrundar till 1, -1 eller 0
# Argument 1: Number/Int/float
# Return: Int. 1 om värdet är större än sqrt(2) / 2, -1 om värdet är minder än -sqrt(2) / 2 eller annars 0
# Exempel:
#           round_angle(0) => 0
#           round_angle(1) => 1
#           round_angle(-1) => -1
#           round_angle(0.71) => 1
#           round_angle(0.70) => 0
#           round_angle(0) => 0
# Datum: 23/4/2024
# Namn: Noah Westerberg
def round_angle(num)
    if num < (Math.sqrt(2) / 2) && num > -(Math.sqrt(2) / 2)
        return 0
    elsif num < -(Math.sqrt(2) / 2)
        return -1
    else 
        return 1
    end
end

class Piece
    # Beskrivning: Returnerar pjäsens icon
    # Return: String: pjäsens icon
    # Exempel: 
    #       Pawn.icon => "P"
    #       Knigth.icon => "Kn"
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
    # Return: Cordinets: pjäsens position
    # Exempel:
    #       Piece.position => #<struct Cordinets x=0, y=0>
    #       Piece.position => #<struct Cordinets x=3, y=3>
    #       Piece.position => #<struct Cordinets x=7, y=5>
    #       Piece.position => #<struct Cordinets x=nil, y=nil>
    # Datum: 22/4/2024
    # Namn: Noah Westerberg
    def position
        return @position
    end

    # Beskrivning: Muterar pjäsens position. Flytar pjäsen på brädan och lämnar indexet den var på som ett blankt object (inplace). Om det är viktigt för pjäsen så sparas det att den har flytat på sig
    # Argument 1: Cordinets: Positionen som pjäsen ska flyta sig till.
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
    end
end

class Pawn < Piece
    def initialize(position, color)
        @icon = "P"
        @color = color
        @position = position
        @has_moved = false
    end

    def has_moved
        return @has_moved
    end

    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Cordinets[]: tillgängliga positioner
    # Exempel:
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        if board[@position.y + 1][@position.x].class == Empty
            positions.append(Cordinets.new(@position.x, @position.y + 1))
        end
        check_square = board[@position.y + 1][@position.x - 1]
        if check_square.class != Empty
            if check_square.color != @color
                positions.append(Cordinets.new(@position.x - 1, @position.y + 1))
            end
        end
        check_square = board[@position.y + 1][@position.x + 1]
        if check_square.class != Empty
            if check_square.color != @color
                positions.append(Cordinets.new(@position.x + 1, @position.y + 1))
            end
        end
        if @has_moved
            return positions
        end
        if board[@position.y + 2][@position.x].class == Empty
            positions.append(Cordinets.new(@position.x, @position.y + 2))
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
    end

    def has_moved
        return @has_moved
    end
    # Beskrivning: Undersöker vart det är tillgängligt att flytta till.
    # Argument 1: 2D-Array: spelbrädan
    # Return: Cordinets[]: tillgängliga positioner
    # Exempel:
    # Datum: 23/4/2024
    # Namn: Noah Westerberg
    def find_moves(board)
        positions = []
        angle = 0
        while angle < 2 * Math::PI
            new_position = Cordinets.new(@position.x + round_to_one(Math.cos(angle)), @position.y + round_to_one(Math.sin(angle)))
            check_square = board[new_position.y][new_position.x]
            if check_square.class == Empty
                positions.append(new_position)
            elsif check_square.color != @color
                positions.append(new_position)
            end
            angle += Math::PI / 4
        end

        return positions
    end
end

class Queen < Piece
    def initialize(position, color)
        @icon = "Q"
        @color = color
        @position = position
    end

    def find_moves(board)

    end
end

class Knight < Piece
    def initialize(position, color)
        @icon = "Kn"
        @color = color
        @position = position
    end

    def find_moves(board)

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

    def find_moves(board)

    end
end

class Bishop < Piece
    def initialize(position, color)
        @icon = "B"
        @color = color
        @position = position
    end

    def find_moves(board)

    end
end