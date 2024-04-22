class Empty
    def initialize
        @icon = "#"
    end
    def icon
        return @icon
    end
end

Cordinets = Struct.new(:x, :y) do
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

    def move(position)
        @position = position
        if (@has_moved != nil)
            @has_moved = true
        end
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

    def find_moves(board)

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

    def find_moves(board)

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


