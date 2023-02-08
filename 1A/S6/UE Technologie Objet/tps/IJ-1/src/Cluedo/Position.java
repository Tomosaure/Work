package Cluedo;

public class Position {
    public int x, y;
    public Position precedente;

    public Position(int x, int y) {
        this.x = x;
        this.y =y;
    }

    public Position(int x, int y, Position precedente) {
        this.x = x;
        this.y =y;
        this.precedente = precedente;
    }

    public String toString() {
        return "["+x + ", " + y + "]";
    }

    public boolean equals(Object o) {
        Position pos = (Position) o;
        return x == pos.x && y == pos.y;
    }

    public Position decalage(int dx, int dy) { 
        return new Position(x + dx, y + dy, this);  
    }
}
