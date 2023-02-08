package Cluedo;

import java.util.LinkedList;

public class Pion {

    Position pos;

    LinkedList<Pion> pion;
    String nom;

    public Pion (Position pos, String nom_pion, LinkedList<Pion> pion) {
        this.pos = pos;
        this.nom = nom_pion;
    }
    public void deplacer(int dx, int dy) {
        this.pos.x += dx;
        this.pos.y += dy;
    }
}
