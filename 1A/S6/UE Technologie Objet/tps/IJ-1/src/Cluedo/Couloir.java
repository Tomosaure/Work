package Cluedo;

public class Couloir extends Case {
    
    public Couloir(Position pos) {
        super(pos);
    }

    public void ajouterJoueur(Joueur j) {
        this.joueur = j;
    }
}
